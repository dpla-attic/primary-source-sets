##
# Handles HTTP requests for tags_vocabularies
#
# @see Sequence
class SequencesController < ApplicationController
  before_action :authenticate_admin!

  # Custom POST route that updates the positions for a group of sequences.
  def sort
    params[:sequence].each_with_index do |id, index|
      Sequence.where(id: id).update_all(position: index)
    end
    render nothing: true
  end
end
