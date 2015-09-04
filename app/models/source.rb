class Source < ActiveRecord::Base
  belongs_to :source_set
  validates :aggregation, presence: true

  def aggregation_uri
    Settings.frontend.url + 'item/' + aggregation
  end
end
