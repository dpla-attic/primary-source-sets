require 'rails_helper'

describe 'source_sets/show.html.erb', type: :view do

  let(:source_set) { create(:source_set_factory) }
  let(:source) { create(:source_factory, source_set: source_set) }
  let(:guide) { create(:guide_factory, source_set: source_set) }

  before { assign(:source_set, source_set) }

  it_behaves_like 'renderable view'

  it 'renders the source set' do
    render
    expect(rendered).to include(source_set.name)
  end

  it 'shows all its sources' do
    source
    render
    expect(rendered).to include(source.name)
  end

  it 'shows all its guides' do
    guide
    render
    expect(rendered).to include(guide.name)
  end

  context 'logged in manager' do
    before do
      admin = create(:admin_factory)
      sign_in admin
    end

    it 'shows year' do
      render
      expect(rendered).to include(source_set.year.to_s)
    end

    it 'links to source_set#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_source_set_path(source_set)}\"")
    end
  end

  context 'logged in editor' do
    before do
      admin = create(:editor_admin_factory)
      sign_in admin
    end

    it 'shows year' do
      render
      expect(rendered).to include(source_set.year.to_s)
    end

    it 'links to source_set#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_source_set_path(source_set)}\"")
    end
  end

  context 'logged in reviewer' do
    before do
      admin = create(:reviewer_admin_factory)
      sign_in admin
    end

    it 'shows year' do
      render
      expect(rendered).to include(source_set.year.to_s)
    end

    it 'does not link to source_set#edit' do
      render
      expect(rendered)
        .not_to include("<a href=\"#{edit_source_set_path(source_set)}\"")
    end
  end
end
