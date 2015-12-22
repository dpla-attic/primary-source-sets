##
# This checks that a new media view renders without error.
# It checks that the s3form partial renders, but stubs out the partial itself.
shared_examples 'renderable new media view' do
  it 'renders the view' do
    expect do
      stub_template 'shared/_s3form.erb' => 's3form content'
      render
    end.not_to raise_error 
  end

  it 'renders the s3form partial' do
    stub_template 'shared/_s3form.erb' => 's3form content'
    render
    expect(rendered).to include('s3form content')
  end
end
