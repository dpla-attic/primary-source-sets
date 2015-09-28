require 'rails_helper'

describe Author, type: :model do

  it 'has and belongs to many source_sets' do
    expect(Author.reflect_on_association(:source_sets).macro.should)
      .to eq :has_and_belongs_to_many
  end

  it 'has and belongs to many guides' do
    expect(Author.reflect_on_association(:guides).macro.should)
      .to eq :has_and_belongs_to_many
  end

  it 'is invalid without name' do
    expect(Author.new(name: nil)).not_to be_valid
  end
end
