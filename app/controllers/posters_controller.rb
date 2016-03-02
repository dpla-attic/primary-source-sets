##
# Handles requests for posters, which represent source sets.
#
# @see SourceSet
class PostersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @source_sets = SourceSet.all
    @guides = Guide.all
  end

  def show
    @type = params[:type]
    if (@type == 'set')
      @source_set = SourceSet.friendly.find(params[:id])
    elsif (@type == 'guide')
      @guide = Guide.friendly.find(params[:id])
      @source_set = @guide.source_set
    end
  end
end
