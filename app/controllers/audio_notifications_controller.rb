##
# Respond to notifications from Zencoder about job status, updating the
# appropriate Audio record.
#
class AudioNotificationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_admin!
  include ZencoderAuthentication

  ##
  # Accept posted JSON data from Zencoder representing a job. Look up the Audio
  # with that job ID and update its status.
  #
  def create
    render(nothing: true, status: :bad_request) and return \
      unless params.include?(:job)
    create_notification(Audio)
  end
end