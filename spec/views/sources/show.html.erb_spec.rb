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
    expect(rendered).to include(source.aggregation)
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
