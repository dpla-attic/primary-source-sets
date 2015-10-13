module PSSBrowserUploads

  # FIXME:  refactor into a base class and child classes for different kinds
  # of form definitions, to deduplicate code.
  #
  class FormDefinition < S3BrowserUploads::FormDefinition

    ##
    # @see S3BrowserUploads::FormDefinition#endpoint
    #
    # We have to override this because the base class creates URLs that are
    # not resolvable with the US Standard Region.
    #
    def endpoint
      "https://#{bucket}.s3.amazonaws.com"
    end
  end

  module_function

  ##
  # Return a FormDefinition for our audio and video upload forms with all
  # of the necessary "policy" fields and signature for S3.
  #
  # This will be used as an argument to `s3_form` in views/shared/_s3form.erb.
  #
  def av_form_definition(type)
    @formdef = PSSBrowserUploads::FormDefinition.new({
      region:                Settings.aws.region,
      aws_access_key_id:     Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      bucket:                Settings.aws.s3_upload_bucket,
      expires:               Time.now + 1800
    })
    @formdef.add_field('key', "#{type}/${filename}")
    @formdef.add_condition('key', 'starts-with' => "#{type}/")
    @formdef.add_field('Content-Type', '')
    @formdef.add_condition('Content-Type', 'starts-with' => '')
    @formdef.add_field('success_action_status', '201')
    @formdef
  end

  def nonav_form_definition(type)
    @formdef = PSSBrowserUploads::FormDefinition.new({
      region:                Settings.aws.region,
      aws_access_key_id:     Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      bucket:                Settings.aws.s3_destination_bucket,
      expires:               Time.now + 1800
    })
    @formdef.add_field('key', "${filename}")
    @formdef.add_condition('key', 'starts-with' => "")
    @formdef.add_field('Content-Type', '')
    @formdef.add_condition('Content-Type', 'starts-with' => '')
    @formdef.add_field('success_action_status', '201')
    @formdef
  end
end
