##
# Encoder: a mixin for controllers that generate Zencoder encoding jobs
#
# Such controllers need to respond to a POST from the browser-side
# `UploadHandler.postAssetRecord()' and then initiate an encoding job with the
# given data.
#
# The controller's `#create' method will call `#create_media'.
#
module Encoder
  extend ActiveSupport::Concern

  ##
  # Create encoding job and store the job ID.
  #
  def create_media(model, type)
    begin
      model[:transcoding_job] =
        create_transcoding_job(params[type.to_s][:key], model[:file_base],
                               Settings["#{type}_outputs"])
    rescue RuntimeError => e
      msg = "Could not create #{type.to_s.capitalize} transcoding job: " \
            "#{e.message}"
      logger.error msg
      render json: { message: msg }, status: :internal_server_error
      return
    end

    model[:meta] = initial_media_meta

    if model.save
      render json: { id: model.id,
                     resource: self.send("#{type}_path", model) },
             status: :created
    else
      msg = "Could not save #{model.capitalize} record"
      logger.error msg
      render json: { message: msg }, status: :internal_server_error
    end
  end

  ##
  # @abstract Return the appropriate Settings array of hashes, i.e.
  # video_outputs or audio_outputs.  These are the file extensions that will be
  # generated.
  #
  def media_outputs
    raise NotImplementedError
  end


  private

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
      notifications: transcoding_notifications,
      credentials: zc_credentials
    }.compact
    Zencoder.api_key = Settings.zencoder.api_key
    logger.info "Creating job with: #{job_opts}"
    response = Zencoder::Job.create(job_opts)
    raise "Could not create transcoding job (status #{response.code})" \
      unless response.code == '201'
    response.body['id'].to_s
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
      file[:credentials] = zc_credentials
      out << file.compact
    end
    out
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

  def zc_credentials
    Settings.zencoder.s3_credentials_name || nil
  end

  ##
  # @abstract Return controller URL appropriate to the particular media
  # controller.
  #
  # @see #transcoding_notifications
  #
  def notifications_url
    raise NotImplementedError
  end
end
