##
# Handles HTTP requests for sources
#
# @see Source
class SourcesController < ApplicationController
  before_filter :load_source_set, only: [:index, :new, :create]

  def index
    redirect_to @source_set
  end

  def show
    @source = Source.find(params[:id])
  end

  def new
    @source = @source_set.sources.new
  end

  def edit
    @source = Source.find(params[:id])
  end

  def create
    @source = @source_set.sources.new(source_params)

    if @source.save
      redirect_to @source
    else
      render 'new'
    end
  end

  def update
    @source = Source.find(params[:id])

    if @source.update(source_params)
      redirect_to @source
    else
      render 'edit'
    end
  end

  def destroy
    @source = Source.find(params[:id])
    @source.destroy

    redirect_to @source.source_set
  end

  private

  def source_params
    params.require(:source).permit(:name,
                                   :aggregation,
                                   :textual_content,
                                   :citation,
                                   :credits,
                                   :featured,
                                   asset_ids: [],
                                   image_ids: [],
                                   audio_ids: [],
                                   video_ids: [],
                                   document_ids: [])
  end

  def load_source_set
    @source_set = SourceSet.friendly.find(params[:source_set_id])
  end
end
