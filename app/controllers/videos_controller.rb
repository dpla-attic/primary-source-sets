##
# Handles HTTP requests for Videos
#
# @see Video
class VideosController < ApplicationController
  before_filter :load_source, only: [:index, :new, :create]

  def index
    redirect_to @source
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = @source.build_video
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    @video = @source.build_video(video_params)

    if @video.save
      redirect_to @video
    else
      render 'new'
    end
  end

  def update
    @video = Video.find(params[:id])

    if @video.update(video_params)
      redirect_to @video
    else
      render 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to @video.source
  end

  private

  def video_params
    params.require(:video).permit(:source_id,
                                  :mime_type,
                                  :file_base)
  end

  ##
  # Find the source through the HTTP route.
  # This method is only for use those actions nested under source.
  def load_source
    @source = Source.find(params[:source_id])
  end
end
