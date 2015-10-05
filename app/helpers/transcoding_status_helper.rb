module TranscodingStatusHelper
  def transcoding_status(model_instance)
    meta = JSON.parse(model_instance.meta)
    s = meta.fetch('job', {}).fetch('state', false)
    "<div class=\"trans-status\">Transcoding status: " \
      "#{s ? s : 'pending'}</div>\n"
  end
end
