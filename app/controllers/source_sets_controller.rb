##
# Handles HTTP requests for source sets
#
# @see SourceSet
class SourceSetsController < ApplicationController

  def index
    @tags = get_tags_from_params
    @order = params[:order]
    @published_sets = SourceSet.published.order_by(@order).with_tags(@tags)
    @unpublished_sets = SourceSet.unpublished.order_by(@order).with_tags(@tags)

    respond_to do |format|
      format.json { render partial: 'source_sets/index.json.erb' }
    end
  end

  def show
    @source_set = SourceSet.friendly.find(params[:id])
    @authors = @source_set.authors
    @sources = @source_set.sources
    @guides = @source_set.guides
    @tags = @source_set.tags
    @related = @source_set.related_sets

    respond_to do |format|
      format.json { render partial: 'source_sets/show.json.erb' }
    end
  end


  private
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
