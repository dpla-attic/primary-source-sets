class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_admin!

  ##
  # Given information about an uploaded file in our "incoming" S3 bucket,
  # create an encoding job with Zencoder.
  #
  # @return [String]  Zencoder job ID
  # @raise [Zencoder::HTTPError] if no TCP/IP connection to Zencoder
  # @raise [RuntimeError]        if HTTP request is unsuccessful
  def create_transcoding_job(s3_key, file_base, outputs_settings)
    job_opts = {
      input: input_location(s3_key),
      outputs: transcoding_outputs(file_base, outputs_settings),
      notifications: transcoding_notifications
    }
    Zencoder.api_key = Settings.zencoder.api_key
    logger.info "Creating job with: #{job_opts}"
    response = Zencoder::Job.create(job_opts)
    raise "Could not create transcoding job (status #{response.code})" \
      unless response.code == '201'
    response.body['id'].to_s
  end

  ##
  # Create the initial `meta` field contents for when a model is first saved.
  #
  # Add essential properties: the CDN domain where the transcoded files will
  # be served and the list of file output settings, representing the transcoded
  # derivatives.
  #
  # @see create_media
  #
  def initial_media_meta
    { cloudfront_domain: Settings.aws.cloudfront_domain,
      output_settings: media_outputs }.to_json
  end

  def input_location(s3_key)
    "s3://#{Settings.aws.s3_upload_bucket}/#{s3_key}"
  end

  ##
  # @see VideosController#create
  # @see AudiosController#create
  #
  def create_media(model, type)
    # Create encoding job and store the job ID.
    model[:transcoding_job] =
      create_transcoding_job(params[type.to_s][:key], model[:file_base],
                             Settings["#{type}_outputs"])

    model[:meta] = initial_media_meta

    if model.save
      render json: { id: model.id,
                     resource: self.send("#{type}_path", model) },
             status: :created
    else
      # TODO: confirm that this is the right status to return.  Under what
      # conditions should this be reached?
      render json: { message: "Could not save #{model.capitalize} record" },
             status: :internal_server_error
    end
  end

  ##
  # Update the appropriate media model with transcoding job status.
  #
  # @see VideoNotificationsController
  # @see AudioNotificationsController
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

  ##
  # Return the appropriate Settings array of hashes, i.e. video_outputs or
  # audio_outputs.
  #
  def media_outputs
    raise "Must be overridden in the particular controller"
  end

  ##
  # Return controller URL appropriate to the particular media controller.
  # @see #transcoding_notifications
  #
  def notifications_url
    raise "Must be overridden in the particular controller"
  end

  ##
  # Return a URL for the "notifications" property of the JSON object that gets
  # sent to Zencoder to tell it where to send its HTTP notification when the
  # job is finished.
  #
  # @see #create_transcoding_job
  #
  def transcoding_notifications
    if Rails.env.production? || Settings.dev_real_zc_notification
      return [notifications_url]
    else
      return ["http://zencoderfetcher/"]
    end
  end

  ##
  # Return an array of hashes for the "outputs" property of the JSON object
  # that gets sent to Zencoder to tell it what output files to produce.
  #
  # @param basename [String] File base name (without path or extension)
  # @param outputs_settings [Array] of Config::Options
  # @see #create_transcoding_job
  #
  def transcoding_outputs(basename, outputs_settings)
    out = []
    outputs_settings.each do |settings|
      file = {}
      file[:url] = "s3://#{Settings.aws.s3_destination_bucket}/" \
                   "#{basename}#{settings.suffix}.#{settings.extension}"
      file[:size] = settings.size
      file[:h264_profile] = settings.h264_profile
      out << file.compact
    end
    out
  end
end
