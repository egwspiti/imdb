module Imdb
  # Movie class encapsulates an imdb entry for a movie
  class Movie

    # @return [String] unique imdb ttid
    attr_reader :id

    # @return [String] movie name
    attr_reader :name

    # @return [Fixnum] number of votes
    attr_reader :votes

    # @return [Fixnum] movie duration in minutes
    attr_reader :duration

    # @return [Fixnum] user rating * 10
    attr_reader :rating

    # @return [Date] release date
    attr_reader :release_date

    # @return [Array<Symbol>] a list of genres associated with this movie
    attr_reader :genres

    # @return [String] plot summary
    attr_reader :plot

    # @param [String] id unique imdb ttid
    # @param [String] name movie name
    # @param [Fixnum] votes number of votes
    # @param [Fixnum] duration movie duration in minutes
    # @param [Fixnum] rating user rating * 10
    # @param [Date] release_date release date
    # @param [Array<Symbol>] genres a list of genres associated with this movie
    def initialize(id: id, name: name, votes: votes, duration: duration, rating: rating, release_date: release_date,genres: genres, plot:)
      @id = id
      @name = name
      @votes = votes
      @duration = duration
      @rating = rating
      @release_date = release_date
      @genres = genres
      @plot = plot
    end
  end
end
