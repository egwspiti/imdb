require 'spec_helper'
require 'imdb'

module Imdb
  describe Imdb do
    context '.get' do
      let(:id) { 'tt2415458' }
      let(:endpoint) { MovieEndpoint.new(id).tap { |e| e.doc = Fixtures::doc_for_id(id) } }

      it 'can get a movie by imdb id' do
        expect(subject.get(id: id)).to be_instance_of(Movie)
      end

      it 'prepends \'tt\' to id if needed' do
        expect(MovieEndpoint).to receive(:new).with(id).and_call_original
        subject.get(id: 2415458)
      end

      context 'fetched movie' do
        before(:each) { expect(MovieEndpoint).to receive(:new).and_return(endpoint) }
        let(:movie) { subject.get(id: id) }

        it 'has the correct id' do
          expect(movie.id).to eq 'tt2415458'
        end

        it 'has the correct name' do
          expect(movie.name).to eq 'The Wolfpack'
        end

        it 'has the correct number of votes' do
          expect(movie.votes).to eq 2028
        end

        it 'has the correct duration' do
          expect(movie.duration).to eq 90
        end

        it 'has the correct user rating' do
          expect(movie.rating).to eq 71
        end

        it 'has the correct release date' do
          expect(movie.release_date).to eq Date.parse('10 July 2015')
        end

        it 'has the correct genres' do
          expect(movie.genres).to eq [:documentary, :biography]
        end
      end

      context 'tt2236358' do
        before(:each) { expect(MovieEndpoint).to receive(:new).and_return(endpoint) }
        let(:id) { 'tt2236358' }
        let(:movie) { subject.get(id: id) }

        it 'parses not released yet date as nil' do
          expect(movie.release_date).to be_nil
        end
      end
    end
  end
end
