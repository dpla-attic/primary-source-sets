##
# NotificationEndpoint: a mixin for controllers that serve as Zencoder
# notification endpoints.
#
# Zencoder sends a POST to a resource specified when an encoding job is created
# to tell our application when the job has finished, and how it went.
#
module NotificationEndpoint
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with name: Settings.zencoder.notification_user,
                                 password: Settings.zencoder.notification_pass
  end

  ##
  # Update the appropriate media model with transcoding job status.
  #
  def create_notification(model_class)
    job_id = params[:job][:id].to_s
    state = params[:job][:state]
    logger.info "#{model_class.to_s} job notification from " \
                "#{request.remote_ip}: " \
                "job ID #{job_id}, state: #{state}"
    record = model_class.find_by_transcoding_job(job_id)

    if !record.nil?
      meta = JSON.parse(!record[:meta].nil? ? record[:meta] : '{}')
      meta[:job] = params[:job]
      meta[:outputs] = params[:outputs]
      record[:meta] = meta.to_json
      record.save
      render nothing: true, status: :created
    else
      logger.info "Can not look up job ID #{job_id}"
      render nothing: true, status: :unprocessable_entity
    end
  end
end
