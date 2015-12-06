require 'scrapr/scraper'
require 'scrapr/helpers/xpath'

module Imdb
  class MovieScraper < Scrapr::Scraper
    include Scrapr::Helpers::Xpath

    # Parse type
    #
    # @return [Symbol] movie type
    def type
      infobar_node = xpath('//div[@class="infobar"]')
      type_text = infobar_node.xpath('./text()[1]').text
      t = type_text.gsub(/[[:space:]]+/,' ').strip
      return :feature_film if t.empty?
      case t
      when 'TV Movie'
        :tv_movie
      when 'TV Episode'
        :tv_episode
      when 'TV Series'
        :tv_series
      else
        require 'pry'; binding.pry
      end
    end

    # Parse name
    #
    # @return [String] movie name
    def name
      name = xpath_text('//td[@id="overview-top"]/h1[@class="header"]/span[@itemprop="name"][@class="title-extra"]')
      name.empty? ? xpath_text('//h1[@class="header"]/span[@itemprop="name"][@class="itemprop"]') : name[/"([^"]*)"/, 1]
    end

    # Parse number of votes
    #
    # @return [Fixnum] number of votes
    def votes
      return nil if under_development
      xpath_text('//span[@itemprop="ratingCount"]').gsub(',', '').to_i
    end

    # Parse duration
    #
    # @return [Fixnum] movie duration in minutes
    def duration
      return nil if under_development
      xpath_text('//*[@itemprop="duration"]').to_i
    end

    # Parse user rating
    #
    # @return [Fixnum] user rating * 10
    def rating
      return nil if under_development
      xpath_text('//span[@itemprop="ratingValue"]').gsub(/\./, '').to_i
    end

    # Parse release date
    #
    # @return [Date] release date
    def release_date
      return nil if under_development
      date_node = at('//meta[@itemprop="datePublished"]/@content[1]')
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
      at('//h1[@class="header"]/span[@class="nobr"]')
    end

    # Parse genres
    #
    # @return [Array<Symbol>] list of genres associated with this movie
    def genres
      xpath('//span[@itemprop="genre"]/text()').map(&:text).map(&:downcase).map(&:to_sym)
    end

    # Parse plot
    #
    # @return [String] A summary of the plot
    def plot
      return nil if under_development
      at_text('//p[@itemprop="description"]/text()').strip
    end

    def under_development
      !!at('//span[@class="pro-link"]')
    end

    # @return [Hash] a hash representing the parsed properties
    def to_h
      { type: type, name: name, votes: votes, duration: duration, rating: rating,
        release_date: release_date, genres: genres, plot: plot, under_development: under_development }
    end
  end
end
