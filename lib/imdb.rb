require "imdb/version"
require 'imdb/movie_endpoint'
require 'imdb/movie_scraper'
require 'imdb/movie'
require 'imdb/movie_not_found'

# Imdb module handles interaction with imdb.
#
# Imdb movies are represented by instances of Imdb::Movie class.
# Imdb web pages are parsed with the help of Imdb::MovieEndpoint class.
module Imdb
  # Get a Movie object representing the imdb movie for the given id
  #
  # @param [String] id unique imdb ttid
  # @return [Movie] Movie object representing the imdb movie for the given id
  def self.get(id:)
    id = "tt#{id}" unless "#{id}".start_with? 'tt'
    endpoint = MovieEndpoint.new(id)
    scraper = MovieScraper.new(endpoint.doc)
    Movie.new(scraper.to_h.merge(id: id))
  end
end
