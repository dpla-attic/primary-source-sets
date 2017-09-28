module ApplicationHelper

  ##
  # Returns frontend path with correctly joining '/'
  # @param path String (with or without leading slash)
  # @return String
  def frontend_path(path = '')
    Settings.frontend.url.chomp('/') + '/' + path.sub(/^\/+/) { $1 }
  end

  ##
  # Returns frontend path with correctly joining '/'
  # @param path String (with or without leading slash)
  # @return String
  def exhibitions_path(path = '')
    Settings.exhibitions.url.chomp('/') + '/' + path.sub(/^\/+/) { $1 }
  end

  ##
  # Returns frontend path with correctly joining '/'
  # @param path String (with or without leading slash)
  # @return String
  def wordpress_path(path = '')
    Settings.wordpress.url.chomp('/') + '/' + path.sub(/^\/+/) { $1 }
  end

  ##
  # Returns frontend path with correctly joining '/'
  # @param path String (with or without leading slash)
  # @return String
  def api_path(path = '')
    Settings.api.url.chomp('/') + '/' + path.sub(/^\/+/) { $1 }
  end

  def base_src
    Settings.app_scheme + Settings.aws.cloudfront_domain + '/'
  end

  ##
  # Get stylesheets from dpla_frontend_assets gem
  def branding_stylesheets
    stylesheet_link_tag('dpla-colors') + stylesheet_link_tag('dpla-fonts') if
      defined? DplaFrontendAssets
  end

  ##
  # Returns DPLA branding images if the frontend-assets gem is available;
  # otherwise returns a placeholder image.
  #
  # @return String name of an image file
  def branding_img(image_name)
    if defined? DplaFrontendAssets
      case image_name
      when 'logo.png'
        'dpla-logo.png'
      when 'footer-logo.png'
        'dpla-footer-logo.png'
      else
        image_name
      end
    else
      image_name
    end
  end

  ##
  # Generate a Twitter web intent link using the URL and title of the current
  # page.
  #
  # @return String
  # @see https://dev.twitter.com/web/tweet-button/parameters
  def twitter_web_intent
    'https://twitter.com/share?' \
    "url=#{request.original_url}&" \
    "related=#{Settings.twitter_username}&" \
    "via=#{Settings.twitter_username}&" \
    "text=#{content_for :title}"
  end

  def rep_file_name(filename)
    filename.sub(/(?:_sm|_thumb)?(\.[a-z]*)$/i, '_rep\1')
  end

end
