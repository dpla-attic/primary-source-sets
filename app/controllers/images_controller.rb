##
# Handles HTTP requests for Images
#
# @see Image
class ImagesController < ApplicationController

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
    @base_src = Settings.app_scheme + Settings.aws.cloudfront_domain + '/'
  end

  def new
    @image = Image.new
    @formdef = PSSBrowserUploads.nonav_form_definition('image')
    @accepted_types = %w(.jpg .jpeg .png .gif).join(',')
  end

  def create
    @image = Image.new(image_params)
    @image.meta = {
      cloudfront_domain: Settings.aws.cloudfront_domain
    }.to_json

    if @image.save
      render json: { id: @image.id, resource: image_path(@image) },
             status: :created
    else
      render json: { message: "Could not save Image record" },
             status: :internal_server_error
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:file_name,
                                  :size,
                                  :height,
                                  :width,
                                  :alt_text,
                                  source_ids: [])
  end
end
