require 'nokogiri'
require 'open-uri'

module Imdb
  # MovieEndpoint class fetches and parses data from imdb.com
  class MovieEndpoint

    #@return [String] unique imdb ttid
    attr_reader :id

    # Nokogiri document for this movie
    #
    # @return [Nokogiri::HTML::Document] nokogiri document for the movie
    def doc
      @doc ||= Nokogiri::HTML(open(@url))
    rescue OpenURI::HTTPError => e
      if e.io.status.first == '404'
        raise MovieNotFound.new(@url)
      end
      raise
    end
    attr_writer :doc

    # Set url from id for fetching data.
    #
    # @param [String] id unique imdb ttid
    def initialize(id)
      @id  = id
      @url = "http://www.imdb.com/title/#{id}/"
    end

    # Parse type
    #
    # @return [Symbol] movie type
    def type
      title = doc.at('//title/text()').text
      case title
      when /TV Movie/
        return :tv_movie
      when /TV Episode/
        return :tv_episode
      when /TV Series/
        return :tv_series
      else
        return :feature_film
      end
    end

    # Parse name
    #
    # @return [String] movie name
    def name
      name = doc.xpath('//td[@id="overview-top"]/h1[@class="header"]/span[@itemprop="name"][@class="title-extra"]').text
      if name.empty?
        name = doc.xpath('//h1[@class="header"]/span[@itemprop="name"][@class="itemprop"]').text
        name.empty? ? doc.at('//div[@class="originalTitle"][1]/text()').text : name
      else
        name[/"([^"]*)"/, 1]
      end
    end

    # Parse number of votes
    #
    # @return [Fixnum] number of votes
    def votes
      return nil if under_development
      doc.xpath('//span[@itemprop="ratingCount"]').text.gsub(',', '').to_i
    end

    # Parse duration
    #
    # @return [Fixnum] movie duration in minutes
    def duration
      return nil if under_development
      doc.xpath('//*[@itemprop="duration"][position()=3]').text.to_i
    end

    # Parse user rating
    #
    # @return [Fixnum] user rating * 10
    def rating
      return nil if under_development
      doc.xpath('//span[@itemprop="ratingValue"]').text.gsub(/\./, '').to_i
    end

    # Parse release date
    #
    # @return [Date] release date
    def release_date
      return nil if under_development
      date_node = doc.xpath('//meta[@itemprop="datePublished"]/@content[1]').first
      if date_node
        date_str = date_node.value
        case date_str.size
        when 4
          Date.strptime(date_str, '%Y')
        when 7
          Date.strptime(date_str, '%Y-%m')
        else
          Date.strptime(date_str, '%Y-%m-%d')
        end
      else
        year = yearlink.text.gsub(/\(|\)/, '')
        Date.strptime(year, '%Y')
      end
    end

    def yearlink
      doc.xpath('//h1[@class="header"]/span[@class="nobr"]').first
    end

    # Parse genres
    #
    # @return [Array<Symbol>] list of genres associated with this movie
    def genres
      doc.xpath('//span[@itemprop="genre"]/text()').map(&:text).map(&:downcase).map(&:to_sym)
    end

    # Parse plot
    #
    # @return [String] A summary of the plot
    def plot
      return nil if under_development
      (doc.at('//p[@itemprop="description"]/text()') || doc.at('//div[@itemprop="description"]/text()')).text.strip
    end

    def under_development
      !!doc.xpath('//span[@class="pro-link"]').first
    end

    # @return [Hash] a hash representing the parsed properties
    def to_h
      { id: id, type: type, name: name, votes: votes, duration: duration, rating: rating,
        release_date: release_date, genres: genres, plot: plot, under_development: under_development }
    end
  end
end
