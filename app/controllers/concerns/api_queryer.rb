##
# ApiQueryer: a mixin for controllers that need to query the DPLA API
# and receive a DPLibrary::DocumentCollection
#
module ApiQueryer
  extend ActiveSupport::Concern

  ##
  # Given one or more DPLA item IDs, return an array of items
  #
  # @param [Array<String>] *ids  One or more item IDs
  # @return Array                Array of DPLibrary::Document
  #
  def dpla_items(*ids)
    begin
      DPLibrary::DocumentCollection.new(id: Array(ids)).documents
    rescue NoMethodError
      # Until specific exceptions are added to DPLibrary,
      # DocumentCollection.new will fail with a NoMethodError if it's given a
      # bad API key or item ID. Until that's addressed, handle NoMethodError.
      logger.error "Bad API key #{Settings.api.key} or item IDs #{Array(ids)}"
      return []
    end
  end
end
