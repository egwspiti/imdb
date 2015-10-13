require 'spec_helper'
require 'imdb'

module Imdb
  describe Imdb do
    context '.get' do
      let(:id) { 'tt2415458' }
      let(:endpoint) { MovieEndpoint.new(id).tap { |e| e.doc = Fixtures::doc_for_id(id) } }
      before(:each) { expect(MovieEndpoint).to receive(:new).at_least(:once).and_return(endpoint) }

      it 'can get a movie by imdb id' do
        expect(subject.get(id: id)).to be_instance_of(Movie)
      end

      it 'prepends \'tt\' to id if needed' do
        expect(subject.get(id: 2415458)).to eq subject.get(id: 'tt2415458')
      end
    end

    context 'movie not found' do
      it 'MovieNotFound is raised' do
        expect { subject.get(id: 'a') }.to raise_error(MovieNotFound)
      end
    end
  end
end
