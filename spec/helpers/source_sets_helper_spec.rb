require 'rails_helper'

describe SourceSetsHelper, type: :helper do

  describe '#sort_options' do
    it 'returns an array' do
      expect(helper.sort_options).to be_a Array
    end
  end
end
