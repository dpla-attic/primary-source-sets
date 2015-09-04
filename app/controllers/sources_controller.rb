##
# Handles HTTP requests for sources
#
# @see Source
class SourcesController < ApplicationController
  before_filter :load_source_set

  def show
    @source = @source_set.sources.find(params[:id])
  end

  def new
    @source = @source_set.sources.new
  end

  def edit
    @source = @source_set.sources.find(params[:id])
  end

  def create
    @source = @source_set.sources.new(source_params)

    if @source.save
      redirect_to [@source_set, @source]
    else
      render 'new'
    end
  end

  def update
    @source = @source_set.sources.find(params[:id])

    if @source.update(source_params)
      redirect_to [@source_set, @source]
    else
      render 'edit'
    end
  end

  def destroy
    @source = @source_set.sources.find(params[:id])
    @source.destroy

    redirect_to @source_set
  end

  private

  def source_params
    params.require(:source).permit(:name, :aggregation, :media_type,
                                   :textual_content)
  end

  def load_source_set
    @source_set = SourceSet.find(params[:source_set_id])
  end
end
