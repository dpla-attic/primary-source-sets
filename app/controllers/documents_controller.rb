##
# Handles HTTP requests for Documents
#
# @see Document
class DocumentsController < ApplicationController
  before_filter :load_source, only: [:index, :new, :create]

  def index
    redirect_to @source
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = @source.build_document
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = @source.build_document(document_params)

    if @document.save
      redirect_to @document
    else
      render 'new'
    end
  end

  def update
    @document = Document.find(params[:id])

    if @document.update(document_params)
      redirect_to @document
    else
      render 'edit'
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    redirect_to @document.source
  end

  private

  def document_params
    params.require(:document).permit(:source_id,
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
