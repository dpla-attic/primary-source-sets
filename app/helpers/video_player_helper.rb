module VideoPlayerHelper
  def video_player(video)
    # Fixed mimetypes determined by file extension
    mimetype = {
      'mp4' => 'video/mp4',
      'webm' => 'video/webm',
      'ogg' => 'video/ogg'
    }

    meta = JSON.parse(video.meta)
    outputs = meta['output_settings']
    rv = "<video preload=\"none\" width=\"640\" height=\"480\" controls>\n"
    outputs.each do |out|
      extension = out['extension']
      suffix = out.fetch('suffix', '')
      src = Settings.app_scheme + Settings.aws.cloudfront_domain + '/' \
        + video.file_base + ".#{extension}"
      rv << "<source src=\"#{src}\" type=\"#{mimetype[extension]}\"/>\n"
    end
    rv << "Your browser does not support HTML5 video.\n"
    rv << "</video>\n"
    rv
  end
end
