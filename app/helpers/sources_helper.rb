module SourcesHelper

  def render_media_asset
    return unless @source.main_asset.present?
    case @source.main_asset.class.name
    when 'Image'
      render partial: 'image'
    when 'Document'
      render partial: 'document'
    when 'Audio'
      render partial: 'audio'
    when 'Video'
      render partial: 'video'
    end
  end
end
