##
# Handles HTTP requests for Audios
#
# @see Audios
class AudiosController < ApplicationController
  def index
    @audios = Audio.all
  end

  def show
    @audio = Audio.find(params[:id])
  end

  ##
  # @see VideosController#new
  def new
    @audio = Audio.new
    @formdef = PSSBrowserUploads.av_form_definition('audio')
    @accepted_types = %w(.mp3 .mp2 .mp4a .wav .flac .aif .aiff .wma .mpga .oga
                         .ogg .au .adp .aac .weba).join(',')
  end

  ##
  # @see ApplicationController#create_media
  def create
    @audio = Audio.new(audio_params)
    create_media(@audio, 'audio')
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    redirect_to audios_path
  end

  ##
  # @see ApplicationController#transcoding_notifications
  def notifications_url
    Settings.app_scheme + Settings.zencoder.notification_user + ':' \
      + Settings.zencoder.notification_pass + '@' \
      + Settings.app_host + audio_notifications_path
  end

  ##
  # @see ApplicationController#media_outputs
  def media_outputs
    Settings.audio_outputs.map { |o| o.to_h }
  end

  private

  def audio_params
    params.require(:audio).permit(:file_base,
                                  source_ids: [])
  end
end
