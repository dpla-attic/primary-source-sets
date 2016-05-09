##
# Handles HTTP requests for source sets
#
# @see SourceSet
class SourceSetsController < ApplicationController
  include MarkdownHelper
  add_breadcrumb 'Primary Source Sets', :root_path
  before_action :authenticate_admin!,
                only: [:new, :edit, :create, :update, :destroy]

  def index
    @tags = get_tags_from_params
    @order = params[:order]
    @published_sets = SourceSet.includes(:small_images).published
                               .order_by(@order).with_tags(@tags)
    @unpublished_sets = SourceSet.includes(:small_images).unpublished
                                 .order_by(@order).with_tags(@tags)
  end

  def show
    @source_set = SourceSet.friendly.find(params[:id])
    check_login_and_authorize(:read, SourceSet) unless @source_set.published?
    add_breadcrumb inline_markdown(@source_set.name), source_set_path(@source_set)
    @authors = @source_set.authors
    @sources = @source_set.sources
    @guides = @source_set.guides
    @tags = @source_set.tags

    ##
    # Render HTML or JSON formats unless controller has already redirected or
    # rendered (ie. in the check_login_and_authorize method).
    unless performed?
      respond_to do |format|
        format.html
        format.json { render partial: 'source_sets/show.json.erb' }
      end
    end
  end

  def new
    @source_set = SourceSet.new
    authorize! :create, SourceSet
  end

  def edit
    @source_set = SourceSet.friendly.find(params[:id])
    authorize! :update, SourceSet
  end

  def create
    @source_set = SourceSet.new(source_set_params)
    authorize! :create, SourceSet

    if @source_set.save
      redirect_to @source_set
    else
      render 'new'
    end
  end

  def update
    @source_set = SourceSet.friendly.find(params[:id])
    authorize! :update, SourceSet

    if @source_set.update(source_set_params)
      redirect_to @source_set
    else
      render 'edit'
    end
  end

  def destroy
    @source_set = SourceSet.friendly.find(params[:id])
    authorize! :destroy, SourceSet
    @source_set.destroy

    redirect_to source_sets_path
  end

  private

  def source_set_params
    params.require(:source_set).permit(:name,
                                       :description,
                                       :overview,
                                       :resources,
                                       :published,
                                       :year,
                                       author_ids: [],
                                       tag_ids: [])
  end

  ##
  # @return [Array<Tag>]
  def get_tags_from_params
    return nil unless params[:tags].present?
    Tag.where("slug IN (?)", valid_tags_params)
  end

  ##
  # Get only those :tags params whose characters are solely comprised of
  # letters, numbers or '-'.
  #
  # @return [Array<String>]
  def valid_tags_params
    return [] unless params[:tags].present?
    params[:tags].select do |slug|
      (slug =~ /[^a-zA-Z0-9-]/).nil?
    end
  end
end
