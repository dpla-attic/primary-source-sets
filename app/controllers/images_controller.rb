##
# Handles HTTP requests for Images
#
# @see Image
class ImagesController < ApplicationController
  before_filter :load_attachable, only: [:index, :new, :create]

  def index
    redirect_to @attachable
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = @attachable.images.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = @attachable.images.new(image_params)

    if @image.save
      redirect_to @image
    else
      render 'new'
    end
  end

  def update
    @image = Image.find(params[:id])

    if @image.update(image_params)
      redirect_to @image
    else
      render 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to @image.attachable
  end

  private

  def image_params
    params.require(:image).permit(:attachable_id,
                                  :attachable_type,
                                  :mime_type,
                                  :file_base,
                                  :size,
                                  :height,
                                  :width,
                                  :alt_text)
  end

  ##
  # Find the attachable through the HTTP route.
  # This method is only for use those actions nested under source.
  def load_attachable
    @attachable = Source.find(params[:source_id]) and return if
      params.include?(:source_id)

    @attachable = SourceSet.friendly.find(params[:source_set_id]) if
      params.include?(:source_set_id)
  end
end
