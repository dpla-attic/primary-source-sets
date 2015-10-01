##
# Handles HTTP requests for Audios
#
# @see Audios
class AudiosController < ApplicationController
  before_filter :load_source, only: [:index, :new, :create]

  def index
    redirect_to @source
  end

  def show
    @audio = Audio.find(params[:id])
  end

  ##
  # @see VideosController#new
  def new
    @audio = @source.build_audio
    @formdef = PSSBrowserUploads.form_definition('audio')
    @accepted_types = %w(.mp3 .mp2 .mp4a .wav .flac .aif .aiff .wma .mpga .oga
                         .ogg .au .adp .aac .weba).join(',')
  end

  def edit
    @audio = Audio.find(params[:id])
  end

  ##
  # @see VideosController#create
  def create
    @audio = @source.build_audio(audio_params)
    if @audio.save
      render json: { id: @audio.id, resource: audio_path(@audio) },
             status: :created
    else
      render json: { message: 'Internal Server Error' },
             status: :internal_server_error
    end
  end

  def update
    @audio = Audio.find(params[:id])

    if @audio.update(audio_params)
      redirect_to @audio
    else
      render 'edit'
    end
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy

    redirect_to @audio.source
  end

  private

  def audio_params
    params.require(:audio).permit(:file_base)
  end

  ##
  # Find the source through the HTTP route.
  # This method is only for use those actions nested under source.
  def load_source
    @source = Source.find(params[:source_id])
  end
end
