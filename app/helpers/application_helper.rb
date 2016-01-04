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
end
