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
  end
end
