##
# Handles HTTP requests for source sets
#
# @see SourceSet
class SourceSetsController < ApplicationController
  def index
    @source_sets = SourceSet.all
  end

  def show
    @source_set = SourceSet.friendly.find(params[:id])
  end

  def new
    @source_set = SourceSet.new
  end

  def edit
    @source_set = SourceSet.friendly.find(params[:id])
  end

  def create
    @source_set = SourceSet.new(source_set_params)

    if @source_set.save
      redirect_to @source_set
    else
      render 'new'
    end
  end

  def update
    @source_set = SourceSet.friendly.find(params[:id])

    if @source_set.update(source_set_params)
      redirect_to @source_set
    else
      render 'edit'
    end
  end

  def destroy
    @source_set = SourceSet.friendly.find(params[:id])
    @source_set.destroy

    redirect_to source_sets_path
  end

  private

  def source_set_params
    params.require(:source_set).permit(:name,
                                       :description,
                                       :overview,
                                       :resources,
                                       author_ids: [])
  end
end
