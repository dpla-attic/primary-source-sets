##
# Handles HTTP requests for Documents
#
# @see Document
class DocumentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
    @formdef = PSSBrowserUploads.nonav_form_definition('pdf')
    @formdef.add_field('Content-Type', '')
    @formdef.add_condition('Content-Type', 'starts-with' => '')
    @accepted_types = '.pdf'
    @source = Source.find_by_id(params[:source_id])
  end

  def create
    @document = Document.new(document_params)
    @document.meta = {
      cloudfront_domain: Settings.aws.cloudfront_domain
    }.to_json
    if @document.save
      render json: { id: @document.id, resource: document_path(@document) },
             status: :created
    else
      render json: { message: "Could not save Document record" },
             status: :internal_server_error
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    redirect_to documents_path
  end

  private

  def document_params
    ##
    # Note that :source_ids is expressed as single hash, rather than
    # "source_ids: []", as seen in other controllers.
    # The single hash notation is required to work with the JavaScript code
    # @see: app/javascripts/avupload.js
    params.require(:document).permit(:file_name, :source_ids)
  end
end
