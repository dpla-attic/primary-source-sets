##
# Handles HTTP requests for vocabularies
#
# @see Vocabulary
class VocabulariesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @vocabularies = Vocabulary.all
  end

  def show
    @vocabulary = Vocabulary.friendly.find(params[:id])
  end

  def new
    @vocabulary = Vocabulary.new
  end

  def edit
    @vocabulary = Vocabulary.friendly.find(params[:id])
  end

  def create
    @vocabulary = Vocabulary.new(vocabulary_params)

    if @vocabulary.save
      redirect_to @vocabulary
    else
      render 'new'
    end
  end

  def update
    @vocabulary = Vocabulary.friendly.find(params[:id])

    if @vocabulary.update(vocabulary_params)
      redirect_to @vocabulary
    else
      render 'edit'
    end
  end

  def destroy
    @vocabulary = Vocabulary.friendly.find(params[:id])
    @vocabulary.destroy

    redirect_to vocabularies_path
  end

  private

  def vocabulary_params
    params.require(:vocabulary).permit(:name, :filter, tag_ids: [])
  end
end
