module ApplicationHelper

  def source_name(source)
    source.name.present? ? source.name : source.aggregation
  end

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
  # Get all the authors for an object with related authors
  # @param Guide or SourceSet
  # @return Array
  def authors(authored)
    return unless authored.present?
    authored.authors.map do |author|
      author.affiliation.present? ? author.name + ', ' + author.affiliation :
        author.name
    end
  end
end
