require 'rails_helper'

describe 'sources/show.html.erb', type: :view do

  let(:source) { create(:source_factory) }

  before do
    assign(:source, source)
    assign(:source_set, source.source_set)
  end

  it_behaves_like 'renderable view'

  it 'renders the source' do
    render
    expect(rendered).to include(source.name)
  end

  context 'with a successful API request' do
    let(:dpla_item) { double }
    let(:url) { 'http://example.org/' }
    let(:provider) { 'X' }

    before do
      allow(dpla_item).to receive(:digital_resource_url).and_return(url)
      allow(dpla_item).to receive(:provider).and_return(provider)
      allow(dpla_item).to receive(:contributing_institution)
      allow(dpla_item).to receive(:title)
      allow(dpla_item).to receive(:dpla_frontend_url)
      assign(:dpla_item, dpla_item)
    end

    it 'renders the provider link' do
      render
      expect(rendered)
        .to include("href=\"#{url}\"")
    end

    it 'embeds data attributes with valid google analytics tracker' do
      allow(GoogleAnalytics).to receive(:valid_tracker?).and_return(true)
      render
      expect(rendered).to include("data-provider='#{provider}'")
    end
  end

  context 'with a failed API request' do
    before do
      assign(:dpla_item, [])
    end

    it 'does not render any provider link' do
      expect(rendered).not_to include('View the item on')
    end
  end

  context 'logged in manager' do
    before do
      admin = create(:admin_factory)
      sign_in admin
    end

    it 'links to source#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_source_path(source)}\"")
    end
  end

  context 'logged in editor' do
    before do
      admin = create(:editor_admin_factory)
      sign_in admin
    end

    it 'links to source#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_source_path(source)}\"")
    end
  end

  context 'logged in reviewer' do
    before do
      admin = create(:reviewer_admin_factory)
      sign_in admin
    end

    it 'does not link to source#edit' do
      render
      expect(rendered)
        .not_to include("<a href=\"#{edit_source_path(source)}\"")
    end
  end
end
