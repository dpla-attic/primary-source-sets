##
# Handles HTTP requests for tags_vocabularies
#
# @see TagSequence
class TagSequencesController < ApplicationController
  before_action :authenticate_admin!

  # Custom POST route that updates the positions for a group of tag sequences.
  def sort
    params[:tag_sequence].each_with_index do |id, index|
      TagSequence.where(id: id).update_all(position: index)
    end
    render nothing: true
  end
end
