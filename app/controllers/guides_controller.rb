##
# Handles HTTP requests for guides
#
# @see Guide
class GuidesController < ApplicationController

  def index
    @source_set = load_source_set
    redirect_to @source_set
  end

  def show
    @guide = Guide.friendly.find(params[:id])
    @source_set = @guide.source_set
    @authors = @guide.authors

    respond_to do |format|
      format.json { render partial: 'guides/show.json.erb' }
    end

  end

  private

  ##
  # Find the source set through the HTTP route.
  # This method is only for use those actions nested under source_set.
  def load_source_set
    @source_set = SourceSet.friendly.find(params[:source_set_id])
  end
end
