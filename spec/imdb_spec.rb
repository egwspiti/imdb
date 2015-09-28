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
    end
  end
end
