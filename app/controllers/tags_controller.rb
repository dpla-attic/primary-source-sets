##
# Handles HTTP requests for tags
#
# @see Tag
class TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.friendly.find(params[:id])
  end

  def new
    @tag = Tag.new
    @tag.source_set_ids = [params[:source_set_id]]
    @tag.vocabulary_ids = [params[:vocabulary_id]]
  end

  def edit
    @tag = Tag.friendly.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to @tag
    else
      render 'new'
    end
  end

  def update
    @tag = Tag.friendly.find(params[:id])

    if @tag.update(tag_params)
      redirect_to @tag
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.friendly.find(params[:id])
    @tag.destroy

    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:label,
                                :uri,
                                source_set_ids: [],
                                vocabulary_ids: [])
  end
end
