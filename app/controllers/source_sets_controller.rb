##
# Handles HTTP requests for source sets
#
# @see SourceSet
class SourceSetsController < ApplicationController
  include MarkdownHelper
  add_breadcrumb 'Primary Source Sets', :root_path
  before_action :authenticate_admin!, only: [:new, :edit]

  def index
    @tags = get_tags_from_params
    @order = params[:order]
    @published_sets = SourceSet.published_sets.order_by(@order).with_tags(@tags)
    @unpublished_sets = SourceSet.unpublished_sets.order_by(@order)
                                 .with_tags(@tags)
  end

  def show
    @source_set = SourceSet.friendly.find(params[:id])
    add_breadcrumb inline_markdown(@source_set.name), source_set_path(@source_set)
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
