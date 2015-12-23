##
# This checks that a view renders without error.
shared_examples 'renderable view' do
  it 'renders the view' do
    expect{ render }.not_to raise_error 
  end
end
