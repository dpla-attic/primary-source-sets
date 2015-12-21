##
# Handles HTTP requests for Images
#
# @see Image
class ImagesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
    @formdef = PSSBrowserUploads.nonav_form_definition('image')
    @formdef.add_field('Content-Type', '')
    @formdef.add_condition('Content-Type', 'starts-with' => '')
    @accepted_types = %w(.jpg .jpeg .png .gif).join(',')
    @source = Source.find_by_id(params[:source_id])
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
    ##
    # Note that :source_ids is expressed as single hash, rather than
    # "source_ids: []", as seen in other controllers.
    # The single hash notation is required to work with the JavaScript code
    # @see: app/javascripts/avupload.js
    params.require(:image).permit(:file_name,
                                  :size,
                                  :height,
                                  :width,
                                  :alt_text,
                                  :source_ids)
  end
end
