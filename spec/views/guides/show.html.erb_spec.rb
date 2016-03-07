require 'rails_helper'

describe 'guides/show.html.erb', type: :view do

  let(:guide) { create(:guide_factory) }

  before do
    assign(:guide, guide)
    assign(:source_set, guide.source_set)
  end

  it_behaves_like 'renderable view'

  it 'renders the guide' do
    render
    expect(rendered).to include(guide.name)
  end

  context 'logged in manager' do
    before do
      admin = create(:admin_factory)
      sign_in admin
    end

    it 'links to guide#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_guide_path(guide)}\"")
    end
  end

  context 'logged in editor' do
    before do
      admin = create(:editor_admin_factory)
      sign_in admin
    end

    it 'links to guide#edit' do
      render
      expect(rendered)
        .to include("<a href=\"#{edit_guide_path(guide)}\"")
    end
  end

  context 'logged in reviewer' do
    before do
      admin = create(:reviewer_admin_factory)
      sign_in admin
    end

    it 'does not link to guide#edit' do
      render
      expect(rendered)
        .not_to include("<a href=\"#{edit_guide_path(guide)}\"")
    end
  end
end
