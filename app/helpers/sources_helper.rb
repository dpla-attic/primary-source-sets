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

  ##
  # Render a back link to the referring page if the referring page is a guide or
  # set.  Links from guides or sets to sources may be created by admins, so the
  # applicaiton cannot expect that back URI's can be included in params.
  # Therefore, it is necessary to parse the referring URI to see if it is a
  # guide or set, and render a back link accordingly.
  #
  # @return [String] HTML back link
  def render_back_link
    return unless request.referer.present?
    uri = URI(request.referer)
    # return if referrer is an offsite link
    return unless uri.host == request.host

    uri_path = uri.path
    # return if referrer does not have relative url root
    return unless uri_path.start_with?(Settings.relative_url_root)

    uri_path.slice!(Settings.relative_url_root)
    path = Rails.application.routes.recognize_path(uri_path) rescue nil

    return unless path.present?
    return unless path[:controller] == 'source_sets' || 'guides'
    return unless path[:action] == 'show'

    link_to "« back to #{path_label[path[:controller]]}", request.referer
  end

  private

  def path_label
    { 'source_sets' => 'set', 'guides' => 'guide' }
  end
end
