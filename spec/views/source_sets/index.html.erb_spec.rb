require 'rails_helper'

describe 'source_sets/index.html.erb', type: :view do

  before do
    create(:source_set_factory, name: 'Moomin')
    create(:source_set_factory, name: 'Snorkmaiden', published: true)
    assign(:published_sets, SourceSet.published_sets)
    assign(:unpublished_sets, SourceSet.unpublished_sets)
  end

  it_behaves_like 'renderable view'

  it 'renders each published source set' do
    render
    expect(rendered).to include('Snorkmaiden')
  end

  it 'does not render unpublished source sets' do
    render
    expect(rendered).not_to include('Moomin')
  end

  context 'logged in manager' do
    before do
      admin = create(:admin_factory)
      sign_in admin
    end

    it 'shows unpublished sets' do
      render
      expect(rendered).to include('Moomin')
    end

    it 'links to source_set#new' do
      render
      expect(rendered).to include("<a href=\"#{new_source_set_path}\"")
    end
  end

  context 'logged in editor' do
    before do
      admin = create(:editor_admin_factory)
      sign_in admin
    end

    it 'shows unpublished sets' do
      render
      expect(rendered).to include('Moomin')
    end

    it 'links to source_set#new' do
      render
      expect(rendered).to include("<a href=\"#{new_source_set_path}\"")
    end
  end

  context 'logged in reviewer' do
    before do
      admin = create(:reviewer_admin_factory)
      sign_in admin
    end

    it 'shows unpublished sets' do
      render
      expect(rendered).to include('Moomin')
    end

    it 'does not link to source_set#new' do
      render
      expect(rendered).not_to include("<a href=\"#{new_source_set_path}\"")
    end
  end
end
