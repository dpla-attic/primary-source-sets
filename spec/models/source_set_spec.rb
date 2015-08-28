require 'spec_helper'

describe SourceSet, type: :model do

  it 'is invalid without name' do
    expect(SourceSet.new(name: nil)).not_to be_valid
  end
end
