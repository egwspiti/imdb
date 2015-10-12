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

    context '#name' do
      it 'parses the correct name' do
        expect(subject.name).to eq 'The Wolfpack'
      end
    end

    context '#votes' do
      it 'parses the correct number of votes' do
        expect(subject.votes).to eq 2242
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

    context 'tt2236358' do
      let(:id) { 'tt2236358' }

      it 'parses not released yet date as nil' do
        expect(subject.release_date).to be_nil
      end
    end

    context 'tt2235876' do
      let(:id) { 'tt2235876' }

      it 'parses year only release dates as Jan 1 of that year' do
        expect(subject.release_date).to eq Date.parse('1 Jan 2014')
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
  end
end
