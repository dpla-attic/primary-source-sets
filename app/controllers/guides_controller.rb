##
# Handles HTTP requests for guides
#
# @see Guide
class GuidesController < ApplicationController
  include MarkdownHelper
  before_filter :load_source_set, only: [:index, :new, :create]
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update,
                                             :destroy]
  add_breadcrumb 'Primary Source Sets', :root_path

  def index
    redirect_to @source_set
  end

  def show
    @guide = Guide.friendly.find(params[:id])
    check_login_and_authorize(:read, Guide) unless @guide.source_set.published?
    add_breadcrumb inline_markdown(@guide.source_set.name), source_set_path(@guide.source_set)
    add_breadcrumb 'Guide', guide_path(@guide)
  end

  def new
    @guide = @source_set.guides.new
    authorize! :create, Guide
  end

  def edit
    @guide = Guide.friendly.find(params[:id])
    authorize! :update, Guide
  end

  def create
    @guide = @source_set.guides.new(guide_params)
    authorize! :create, Guide

    if @guide.save
      redirect_to @guide
    else
      render 'new'
    end
  end

  def update
    @guide = Guide.friendly.find(params[:id])
    authorize! :update, Guide

    if @guide.update(guide_params)
      redirect_to @guide
    else
      render 'edit'
    end
  end

  def destroy
    @guide = Guide.friendly.find(params[:id])
    authorize! :destroy, Guide
    @guide.destroy

    redirect_to @guide.source_set
  end

  private

  def guide_params
    params.require(:guide).permit(:name,
                                  :questions,
                                  :activity,
                                  author_ids: [])
  end

  ##
  # Find the source set through the HTTP route.
  # This method is only for use those actions nested under source_set.
  def load_source_set
    @source_set = SourceSet.friendly.find(params[:source_set_id])
  end
end
