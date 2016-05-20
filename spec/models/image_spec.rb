require 'rails_helper'

describe Image, type: :model do

  let(:attributes) { attributes_for(:image_factory) }

  it_behaves_like 'media asset'

  it 'is invalid without size' do
    attributes[:size] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'is invalid without file_name' do
    attributes[:file_name] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  describe 'cache dependencies' do
    let(:image) { create(:image_factory) }
    let(:source) { create(:source_factory) }
    let(:set) { create(:source_set_factory) }

    before { set.sources << source }

    context 'when updated' do
      before(:each) { source.images << image }

      it 'changes cache key of associated source' do
        expect{ image.update_attribute(:alt_text, 'new text') }
          .to change{ source.reload.cache_key }
      end

      it 'changes cache key of sets of associated sources' do
        expect{ image.update_attribute(:alt_text, 'new text') }
          .to change{ set.reload.cache_key }
      end
    end

    context 'when deleted' do
      before(:each) { source.images << image }

      it 'changes cache key of associated source' do
        expect{ image.destroy }.to change{ source.reload.cache_key }
      end

      it 'changes cache key of set of associated sources' do
        expect{ image.destroy }.to change{ set.reload.cache_key }
      end
    end

    context 'when source association created' do
      it 'changes cache key of associated source' do
        expect{ image.sources << source }.to change{ source.reload.cache_key }
      end

      it 'changes cache key of set of associated sources' do
        expect{ image.sources << source }.to change{ set.reload.cache_key }
      end
    end

    context 'when source association deleted' do
      before(:each) { source.images << image }

      it 'changes cache key of associated source' do
        expect{ image.destroy }.to change{ source.reload.cache_key }
      end

      it 'changes cache key of set of associated sources' do
        expect{ image.destroy }.to change{ set.reload.cache_key }
      end
    end
  end
end
