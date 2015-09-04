require 'spec_helper'

describe Source, type: :model do

  it 'belongs to a source set' do
    expect(Source.reflect_on_association(:source_set).macro.should)
      .to eq :belongs_to
  end

  it 'is invalid without aggregation' do
    expect(Source.new(aggregation: nil)).not_to be_valid
  end
end
