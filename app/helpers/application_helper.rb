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

  def rep_file_name(filename)
    filename.sub(/(?:_sm|_thumb)?(\.[a-z]*)$/i, '_rep\1')
  end

end
