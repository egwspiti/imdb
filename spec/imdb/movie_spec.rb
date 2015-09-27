require 'spec_helper'
require 'imdb/movie'

module Imdb
  describe Movie do
    subject { Movie.new(id: 'tt2415458',
                        name: 'The Wolfpack',
                        votes: 2028,
                        duration: 90,
                        rating: 71,
                        release_date: Date.parse('10 July 2015'),
                        genres: [:documentary, :biography],
                        plot: 'Locked away from society in an apartment on the Lower East Side of Manhattan, the Angulo brothers learn about the outside world through the films that they watch. Nicknamed, \'The Wolfpack,\'...') }

    it 'has an id' do
      expect(subject.id).to eq 'tt2415458'
    end

    it 'has a name' do
      expect(subject.name).to eq 'The Wolfpack'
    end

    it 'has a number of votes' do
      expect(subject.votes).to eq 2028
    end

    it 'has a duration' do
      expect(subject.duration).to eq 90
    end

    it 'has a user rating' do
      expect(subject.rating).to eq 71
    end

    it 'has a release date' do
      expect(subject.release_date).to eq Date.parse('10 July 2015')
    end

    it 'has genres' do
      expect(subject.genres).to eq [:documentary, :biography]
    end

    it 'has a plot' do
      expect(subject.plot).to eq 'Locked away from society in an apartment on the Lower East Side of Manhattan, the Angulo brothers learn about the outside world through the films that they watch. Nicknamed, \'The Wolfpack,\'...'
    end
  end
end
