require 'spec_helper'
require 'imdb/movie_endpoint'

module Imdb
  describe MovieEndpoint do

    let(:endpoint) { MovieEndpoint.new(id).tap { |e| e.doc = Fixtures::doc_for_id(id) } }
    before(:each) { expect(MovieEndpoint).to receive(:new).and_return(endpoint) }

    subject { MovieEndpoint.new(id) }

    let(:id) { 'tt2415458' }

    context '.new' do
      it 'accepts an id' do
        expect { MovieEndpoint.new(id) }.not_to raise_error
      end
    end

    context '#type' do
      it 'parses the correct type' do
        expect(subject.type).to eq :feature_film
      end

      context 'tt1334456' do
        let(:id) { 'tt1334456' }

        it 'is a tv movie' do
          expect(subject.type).to eq :tv_movie
        end
      end

      context 'tt4416858' do
        let(:id) { 'tt4416858' }

        it 'is a tv episode' do
          expect(subject.type).to eq :tv_episode
        end
      end

      context 'tt1813862' do
        let(:id) { 'tt1813862' }

        it 'is a tv series' do
          expect(subject.type).to eq :tv_series
        end
      end
    end

    context '#name' do
      it 'parses the correct name' do
        expect(subject.name).to eq 'The Wolfpack'
      end
    end

    context '#votes' do
      it 'parses the correct number of votes' do
        expect(subject.votes).to eq 6176
      end
    end

    context '#duration' do
      it 'parses the correct duration' do
        expect(subject.duration).to eq 90
      end
    end

    context '#rating' do
      it 'parses the correct user rating' do
        expect(subject.rating).to eq 71
      end
    end

    context '#release_date' do
      it 'parses the correct release date' do
        expect(subject.release_date).to eq Date.parse('10 July 2015')
      end
    end

    context '#genres' do
      it 'parses the correct genres' do
        expect(subject.genres).to eq [:documentary, :biography]
      end
    end

    context '#plot' do
      it 'parses the correct plot' do
        expect(subject.plot).to eq 'Locked away from society in an apartment on the Lower East Side of Manhattan, the Angulo brothers learn about the outside world through the films that they watch. Nicknamed, \'The Wolfpack,\'...'
      end
    end

    context '#under_development' do
      it 'is false for finished movies, series, etc' do
        expect(subject.under_development).to be_falsey
      end

      context 'tt1072757' do
        let(:id) { 'tt1072757' }

        it 'is true since this entry is under development and more info are only available through imdb pro' do
          expect(subject.under_development).to be_truthy
        end
      end
    end

    context 'tt3291150 :not released yet' do
      let(:id) { 'tt3291150' }

      it 'parses release date from year link' do
        expect(subject.release_date).to eq Date.parse('1 Jan 2017')
      end
    end

    context 'tt2235876' do
      let(:id) { 'tt2235876' }

      it 'parses year only release dates as Jan 1 of that year' do
        expect(subject.release_date).to eq Date.parse('1 Jan 2014')
      end
    end

    context 'tt0000538 :no release_date info' do
      let(:id) { 'tt0000538' }

      it 'parses release dates from year link' do
        expect(subject.release_date).to eq Date.parse('1 Jan 1906')
      end
    end

    # Usually a tv_episode where there is some kind of release date info for the series
    # but not for the specific episode.
    context 'tt1264528 :no release_date info, no yearlink' do
      let(:id) { 'tt1264528' }

      it 'parses nil release date' do
        expect(subject.release_date).to be_nil
      end
    end

    context 'tt5078450' do
      let(:id) { 'tt5078450' }

      it 'parses month-year only release dates as 1st of that month' do
        expect(subject.release_date).to eq Date.parse('1 Sep 2015')
      end
    end

    context 'tt2268016' do
      let(:id) { 'tt2268016' }

      it 'parses the original name' do
        expect(subject.name).to eq 'Magic Mike XXL'
      end
    end

    context 'tt3825638' do
      let(:id) { 'tt3825638' }

      it 'parses the original name' do
        expect(subject.name).to eq 'Im Labyrinth des Schweigens'
      end
    end

    context 'tt75' do
      let(:id) { 'tt75' }

      it 'parses the correct release date' do
        expect(subject.release_date).to eq Date.parse('1 Jan 1896')
      end

      it 'parses the correct duration' do
        expect(subject.duration).to eq 1
      end
    end

    context 'tt385586' do
      let(:id) { 'tt385586' }

      # This fails probably due to different 'localized' htmls presented by imdb.
      # When requested from USA, the release date seems to be 9 Sep 2003.
      # Otherwise it is 2001.
      it 'parses the correct release date', :skip_ci => true do
        expect(subject.release_date).to eq Date.parse('1 Jan 2001')
      end

      it 'parses the correct duration' do
        expect(subject.duration).to eq 34
      end
    end

    context 'tt4' do
      let(:id) { 'tt4' }

      it 'parses the correct release date' do
        expect(subject.release_date).to eq Date.parse('28 Oct 1892')
      end

      it 'parses nil duration' do
        expect(subject.duration).to be_nil
      end
    end

    context 'tt1072757 :under_development title' do
      let(:id) { 'tt1072757' }

      it 'has a nil release date' do
        expect(subject.release_date).to be_nil
      end

      it 'has a nil plot' do
        expect(subject.plot).to be_nil
      end

      it 'has a nil duration' do
        expect(subject.duration).to be_nil
      end

      it 'has nil votes' do
        expect(subject.votes).to be_nil
      end

      it 'has nil rating' do
        expect(subject.rating).to be_nil
      end
    end
  end
end
