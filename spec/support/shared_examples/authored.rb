##
# Tests for models that include the Authored concern.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
shared_examples 'authored' do

  it 'has and belongs to many authors' do
    expect(described_class.reflect_on_association(:authors).macro)
      .to eq :has_and_belongs_to_many
  end

  describe '#author_list' do
    it 'returns Array of authors with affilations' do
      resource.authors << [create(:author_factory, name: 'x', affiliation: 'y'),
                           create(:author_factory, name: 'z', affiliation: nil)]
      expect(resource.author_list).to include('x, y', 'z')
    end
  end
end
