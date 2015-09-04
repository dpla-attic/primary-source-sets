##
# Handles HTTP requests for guides
#
# @see Guide
class GuidesController < ApplicationController
  before_filter :load_source_set

  def show
    @guide = @source_set.guides.find(params[:id])
  end

  def new
    @guide = @source_set.guides.new
  end

  def edit
    @guide = @source_set.guides.find(params[:id])
  end

  def create
    @guide = @source_set.guides.new(guide_params)

    if @guide.save
      redirect_to [@source_set, @guide]
    else
      render 'new'
    end
  end

  def update
    @guide = @source_set.guides.find(params[:id])

    if @guide.update(guide_params)
      redirect_to [@source_set, @guide]
    else
      render 'edit'
    end
  end

  def destroy
    @guide = @source_set.guides.find(params[:id])
    @guide.destroy

    redirect_to @source_set
  end

  private

  def guide_params
    params.require(:guide).permit(:name,
                                  :questions,
                                  :activity,
                                  author_ids: [])
  end

  def load_source_set
    @source_set = SourceSet.find(params[:source_set_id])
  end
end
