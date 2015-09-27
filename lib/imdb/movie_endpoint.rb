require 'nokogiri'
require 'open-uri'
require 'imdb/movie'

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
    end
    attr_writer :doc

    # Set url for fetching data
    #
    # @param [String] id unique imdb ttid
    def initialize(id)
      @id  = id
      @url = "http://www.imdb.com/title/#{id}/"
    end

    # Parse name from doc
    #
    # @return [String] movie name
    def name
      name = doc.xpath('//td[@id="overview-top"]/h1[@class="header"]/span[@itemprop="name"][@class="title-extra"]').text
      name.empty? ? doc.xpath('//h1[@class="header"]/span[@itemprop="name"][@class="itemprop"]').text : name[/"([^"]*)"/, 1]
    end

    # Parse number of votes from doc
    #
    # @return [Fixnum] number of votes
    def votes
      doc.xpath('//span[@itemprop="ratingCount"]').text.gsub(',', '').to_i
    end

    # Parse duration of movie from doc
    #
    # @return [Fixnum] movie duration in minutes
    def duration
      doc.xpath('//*[@itemprop="duration"]').text.to_i
    end

    # Parse user rating of movie from doc
    #
    # @return [Fixnum] user rating * 10
    def rating
      doc.xpath('//span[@itemprop="ratingValue"]').text.gsub(/\./, '').to_i
    end

    # Parse release date of movie from doc
    #
    # @return [Date] release date
    def release_date
      date_node = doc.xpath('//meta[@itemprop="datePublished"]/@content[1]').first
      if date_node
        date_str = date_node.value
        Date.strptime(date_str, date_str.size == 4 ? '%Y' : "%Y-%m-%d")
      end
    end

    # Parse genres of movie from doc
    #
    # @return [Array<Symbol>] list of genres associated with this movie
    def genres
      doc.xpath('//span[@itemprop="genre"]/text()').map(&:text).map(&:downcase).map(&:to_sym)
    end

    # Create a Movie object for this movie
    #
    # @return [Movie] Movie object representing this movie
    def movie
      Movie.new(id: id, name: name, votes: votes, duration: duration, rating: rating, release_date: release_date, genres: genres)
    end
  end
end
