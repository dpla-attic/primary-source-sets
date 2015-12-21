##
# Handles HTTP requests for Videos
#
# @see Video
class VideosController < ApplicationController
  include Encoder
  before_action :authenticate_admin!

  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  ##
  # Draw the upload-form page with a form for posting to S3
  #
  # FIXME?:  when you hit #new after you've alredy uploaded a video for a
  # source, a DELETE statement is issued that deletes any existing video having
  # the source ID.  It does not clean up any cloud files.
  # Will this ever be an issue?  It could happen if the post-upload AJAX
  # failed and you ended up still on the #new page, and then refreshed it (as
  # I did in development).  The only ill effect would be an unused file in the
  # incoming bucket.
  #
  def new
    @video = Video.new
    @formdef = PSSBrowserUploads.av_form_definition('video')
    @accepted_types = %w(.mov .m4v .mp4 .mpeg .mp1 .3gp .3g2 .avi .f4v .flv
                         .h261 .h263 .h264 .jpm .jpgv .asf .wm .wmv .mj2 .ogv
                         .webm .qt .movie .dv).join(',')
    @source = Source.find_by_id(params[:source_id])
  end

  ##
  # @see Encoder#create_media
  def create
    @video = Video.new(video_params)
    create_media(@video, 'video')
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to videos_path
  end

  ##
  # @see Encoder#transcoding_notifications
  def notifications_url
    Settings.app_scheme + Settings.zencoder.notification_user + ':' \
      + Settings.zencoder.notification_pass + '@' \
      + Settings.app_host + video_notifications_path
  end

  ##
  # @see Encoder#media_outputs
  def media_outputs
    Settings.video_outputs.map { |o| o.to_h }
  end

  private

  def video_params
    ##
    # Note that :source_ids is expressed as single hash, rather than
    # "source_ids: []", as seen in other controllers.
    # The single hash notation is required to work with the JavaScript code
    # @see: app/javascripts/avupload.js
    params.require(:video).permit(:file_base, :source_ids)
  end
end
