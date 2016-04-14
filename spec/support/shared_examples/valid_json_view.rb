##
# This checks that a view renders valid json.
shared_examples 'valid json view' do
  it 'renders valid json' do
    render
    expect { JSON.parse(rendered) }.not_to raise_error
  end
end
