##
# Handles HTTP requests for Videos
#
# @see Video
class VideosController < ApplicationController

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
    @formdef = PSSBrowserUploads.form_definition('video')
    @accepted_types = %w(.mov .m4v .mp4 .mpeg .mp1 .3gp .3g2 .avi .f4v .flv
                         .h261 .h263 .h264 .jpm .jpgv .asf .wm .wmv .mj2 .ogv
                         .webm .qt .movie .dv).join(',')
  end

  def edit
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      render json: { id: @video.id, resource: video_path(@video) },
             status: :created
    else
      # TODO: confirm that this is the right status to return.  Under what
      # conditions should this be reached?
      render json: { message: 'Internal Server Error' },
             status: :internal_server_error
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

    redirect_to videos_path
  end

  private

  def video_params
    params.require(:video).permit(:file_base,
                                  source_ids: [])
  end
end
