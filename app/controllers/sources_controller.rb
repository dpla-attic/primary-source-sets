##
# Handles HTTP requests for sources
#
# @see Source
class SourcesController < ApplicationController

  def index
    @source_set = load_source_set
    redirect_to @source_set
  end

  def show
    @source = Source.find(params[:id])
    @source_set = @source.source_set
    @main_asset = @source.main_asset
    @dpla_item = DplaItem.find(@source.aggregation)
    @file_base_or_name = nil
    @related = @source.related_sources

    if @main_asset.present?
      @file_base_or_name = @main_asset.respond_to?(:file_base) ?
        @main_asset.file_base : @main_asset.file_name
    end

    respond_to do |format|
      format.json { render partial: 'sources/show.json.erb' }
    end
  end

  private

  def load_source_set
    @source_set = SourceSet.friendly.find(params[:source_set_id])
  end
end
