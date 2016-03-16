require 'rails_helper'

module ConcernDouble
  class ApiQueryerDouble < ApplicationController
    include ApiQueryer
  end
end

describe ApiQueryer do

  context 'when included' do

    subject { ConcernDouble::ApiQueryerDouble.new }
    let(:documentcollection) { double() }
    before do
      allow(DPLibrary::DocumentCollection)
        .to receive(:new).and_return(documentcollection)
      allow(documentcollection).to receive(:documents).and_return([])
    end

    describe '#dpla_items' do
      it 'queries the DPLA API for the item ID' do
        expect(DPLibrary::DocumentCollection)
          .to receive(:new).with({id: ['x']})
          .and_return(documentcollection)
        subject.dpla_items('x')
      end

      context 'when the query fails due to bad ID or API key' do
        let (:apikey) { 'thekey' }
        let (:id) { 'theid' }
        before do
          allow(DPLibrary::DocumentCollection).to receive(:new)
            .and_raise(NoMethodError)
          allow(Settings).to receive_message_chain(:api, :key)
            .and_return(apikey)
        end

        it 'logs an error with the API key and item ID' do
          msg = "Bad API key #{apikey} or item IDs #{Array(id)}"
          expect(Rails.logger).to receive(:error).with(msg)
          subject.dpla_items(id)
        end

        it 'returns an empty array' do
          expect(subject.dpla_items(id)).to eq([])
        end
      end
    end

  end

end
