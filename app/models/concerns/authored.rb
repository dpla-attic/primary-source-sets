##
# Functionality for a Model with related authors
module Authored
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :authors
  end

  ##
  # Get all the authors related to the Model with their affiliations
  # @return Array[String]
  def author_list
    authors.map do |author|
      author.affiliation.present? ? author.name + ', ' + author.affiliation :
        author.name
    end
  end
end
