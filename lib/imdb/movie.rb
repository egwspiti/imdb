module Imdb
  # Movie class encapsulates an imdb entry for a movie.
  class Movie

    # @return [String] unique imdb ttid
    attr_reader :id

    # @return [Symbol] type
    attr_reader :type

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

    # @return [Boolean] whether the movie is under development, ie more info are
    # available only at imdb pro
    attr_reader :under_development

    # @param [String] id unique imdb ttid
    # @param [String] name movie name
    # @param [Fixnum] votes number of votes
    # @param [Fixnum] duration movie duration in minutes
    # @param [Fixnum] rating user rating * 10
    # @param [Date] release_date release date
    # @param [Array<Symbol>] genres a list of genres associated with this movie
    def initialize(id:, name:, votes:, duration:, rating:, release_date:, genres:, plot:, type:, under_development:)
      @id = id
      @type = type
      @name = name
      @votes = votes
      @duration = duration
      @rating = rating
      @release_date = release_date
      @genres = genres
      @plot = plot
      @under_development = under_development
    end



    # @return [String] text representation of this movie
    def to_s
      "<#{id}> #{type}, #{release_date.year}, #{rating}/100 (#{votes}), #{duration}min, #{name}, #{genres}, #{plot}"
    end

    # Movie objects are equal if and only if their id, type, name, votes, duration,
    # rating, release_date, genres and plot attributes are the same.
    #
    # @param [Object] other object to compare with.
    # @return [Boolean]
    def ==(other)
      [:id, :type, :name, :votes, :duration, :rating, :release_date, :genres, :plot, :under_development].all? do |m|
        other.respond_to?(m) && self.public_send(m) == other.public_send(m)
      end
    end

    # @return [Hash] hash representation of this movie
    def to_h
      { id: id, type: type, name: name, votes: votes, duration: duration, rating: rating, release_date: release_date, genres: genres, plot: plot, under_development: under_development }
    end
  end
end
