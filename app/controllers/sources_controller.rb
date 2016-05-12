##
# Handles HTTP requests for sources
#
# @see Source
class SourcesController < ApplicationController
  include VideoPlayerHelper
  include AudioPlayerHelper
  include MarkdownHelper
  before_filter :load_source_set, only: [:index, :new, :create]
  before_action :authenticate_admin!,
                only: [:new, :edit, :create, :update, :destroy]
  add_breadcrumb 'Primary Source Sets', :root_path

  def index
    redirect_to @source_set
  end

  def show
    @source = Source.find(params[:id])
    @source_set = @source.source_set
    check_login_and_authorize(:read, Source) unless @source_set.published?
    add_breadcrumb inline_markdown(@source_set.name),
                   source_set_path(@source_set)
    add_breadcrumb 'Source', source_path(@source)
    @main_asset = @source.main_asset
    @dpla_item = DplaItem.find(@source.aggregation)
    @file_base_or_name = nil

    if @main_asset.present?
      @file_base_or_name = @main_asset.respond_to?(:file_base) ?
        @main_asset.file_base : @main_asset.file_name
    end

    ##
    # Render HTML or JSON formats unless controller has already redirected or
    # rendered (ie. in the check_login_and_authorize method).
    unless performed?
      respond_to do |format|
        format.html
        format.json { render partial: 'sources/show.json.erb' }
      end
    end
  end

  def new
    @source = @source_set.sources.new
    authorize! :create, Source
  end

  def edit
    @source = Source.find(params[:id])
    authorize! :update, Source
  end

  def create
    @source = @source_set.sources.new(source_params)
    authorize! :create, Source

    if @source.save
      redirect_to @source
    else
      render 'new'
    end
  end

  def update
    @source = Source.find(params[:id])
    authorize! :update, Source

    if @source.update(source_params)
      redirect_to @source
    else
      render 'edit'
    end
  end

  def destroy
    @source = Source.find(params[:id])
    authorize! :destroy, Source
    @source.destroy

    redirect_to @source.source_set
  end

  private

  def source_params
    params.require(:source).permit(:name,
                                   :aggregation,
                                   :textual_content,
                                   :citation,
                                   :credits,
                                   :featured,
                                   asset_ids: [],
                                   image_ids: [],
                                   audio_ids: [],
                                   video_ids: [],
                                   document_ids: [])
  end

  def load_source_set
    @source_set = SourceSet.friendly.find(params[:source_set_id])
  end
end
