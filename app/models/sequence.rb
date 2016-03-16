##
# The Sequence model correlates to the sequences table, a join table between
# tags and vocuabularies. This table includes the sequential position in which
# tags appear within vocabularies.
class Sequence < ActiveRecord::Base
  belongs_to :tag
  belongs_to :vocabulary
  before_save :set_position
  before_destroy :amend_positions
  default_scope { order('position ASC') }

  private

  ##
  # If self does not have a position, set its position to one greater than the
  # current higest position for its vocabulary.  This will ensure that positions
  # operate correctly as a sequential list.
  #
  # Note that if a value for position is present, this does not check whether or
  # not the position is correctly incremented b/c it would interfere with
  # methods such as :amend_positions. There is no way in the current user
  # interface to set an incorrectly incremented position; however this could be
  # done through the command line.  An incorrectly incremented position may
  # cause the sequence to display in an inconsistent order, but should not cause
  # any errors.
  def set_position
    if position.nil?
      max_position = self.class.where('vocabulary_id = ?', vocabulary_id)
                         .maximum(:position)
      self.position = max_position.present? ? max_position + 1 : 0
    end
  end

  ##
  # Get all Sequences from the same vocabulary with a higher position.
  # Reduce the position of all these Sequences by 1.
  # This will ensure that positions operate correctly as a sequential list, with
  # no gaps.
  def amend_positions
    sequences = self.class.where('vocabulary_id = ?', vocabulary_id)
                    .where('position > ?', position)
    sequences.each do |sequence|
      sequence.decrement(:position)
      sequence.save
    end
  end
end
