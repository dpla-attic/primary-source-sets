require 'rails_helper'

describe DplaItem, type: :model do
  it_behaves_like 'ActiveModel'

  let(:documentcollection) { double }
  let(:doc) { double }

  shared_context 'stub request to DPLibrary' do
    before do
      allow(DPLibrary::DocumentCollection)
        .to receive(:new).and_return(documentcollection)
    end
  end

  shared_context 'stub single doc response from DPLibrary' do
    before do
      allow(documentcollection).to receive(:documents).and_return([doc])
    end
  end

  describe '#find' do
    include_context 'stub request to DPLibrary'

    it 'queries the DPLA API for the item ID' do
      allow(documentcollection).to receive(:documents).and_return([])
      expect(DPLibrary::DocumentCollection)
        .to receive(:new).with(id: ['x'])
        .and_return(documentcollection)
      DplaItem.find('x')
    end

    context 'item not found in DPLA' do
      it 'returns an empty array' do
        allow(documentcollection).to receive(:documents).and_return([])
        expect(DplaItem.find('x')).to be_a Array
        expect(DplaItem.find('x').count).to eq 0
      end
    end

    context 'single item found in DPLA' do
      include_context 'stub single doc response from DPLibrary'

      it 'instantiates a single DplaItem from a single ID' do
        expect(DplaItem.find('x')).to be_a DplaItem
      end

      it 'sets item attribute' do
        expect(DplaItem.find('x').item).to eq doc
      end
    end

    context 'multiple items found in DPLA' do
      it 'instantiates an array of DplaItems from multiple IDs' do
        allow(documentcollection).to receive(:documents)
          .and_return([double, double])
        expect(DplaItem.find('x, y')).to be_a Array
        expect(DplaItem.find('x, y').first).to be_a DplaItem
        expect(DplaItem.find('x, y').second).to be_a DplaItem
      end
    end

    context 'when the query fails due to bad ID or API key' do
      let(:apikey) { 'thekey' }
      let(:id) { 'theid' }
      before do
        allow(DPLibrary::DocumentCollection).to receive(:new)
          .and_raise(NoMethodError)
        allow(Settings).to receive_message_chain(:api, :key)
          .and_return(apikey)
      end

      it 'logs an error with the API key and item ID' do
        msg = "Bad API key #{apikey} or item IDs #{Array(id)}"
        expect(Rails.logger).to receive(:error).with(msg)
        DplaItem.find(id)
      end

      it 'returns an empty array' do
        expect(DplaItem.find(id)).to eq([])
      end
    end
  end

  describe '#contributing_institution' do
    include_context 'stub request to DPLibrary'
    include_context 'stub single doc response from DPLibrary'

    it 'retruns data provider and intermediated provider' do
      allow(doc).to receive(:source).and_return('a')
      allow(doc).to receive(:intermediate_provider).and_return('b')
      expect(DplaItem.find('x').contributing_institution).to eq 'a; b'
    end
  end

  describe '#dpla_frontend_url' do
    include_context 'stub request to DPLibrary'
    include_context 'stub single doc response from DPLibrary'

    it 'returns a URI with the correct path' do
      allow(doc).to receive(:id).and_return('x')
      expect(URI(DplaItem.find('x').dpla_frontend_url).path).to eq '/item/x'
    end
  end
end
