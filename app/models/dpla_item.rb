##
# DplaItem represents an item (aka aggregation) as it is indexed in the DPLA.
# It is populated with data from DPLibrary.
#
# This is a read-only object. DplaItems are not persisted within this
# application.
class DplaItem < ActiveModelBase
  ##
  # @!attribute :item [DPLibrary::Document]
  attr_accessor :item

  ##
  # Finds one or more items from the DPLA index by ID.
  #
  # @param [Array<String>] *ids  One or more item IDs
  # @return DplaItem OR [Array<DplaItem>]
  def self.find(*ids)
    begin
      # Given one or more DPLA item IDs, return an array of items
      response = DPLibrary::DocumentCollection.new(id: Array(ids)).documents
      items = response.map { |item| new(item: item) }
      items.count == 1 ? items.first : items
    rescue NoMethodError
      # Until specific exceptions are added to DPLibrary,
      # DocumentCollection.new will fail with a NoMethodError if it's given a
      # bad API key or item ID. Until that's addressed, handle NoMethodError.
      logger.error "Bad API key #{Settings.api.key} or item IDs #{Array(ids)}"
      return []
    end
  end

  def dpla_frontend_url
    Settings.frontend.url.chomp('/') + '/item/' + item.id
  end

  def digital_resource_url
    Array(item.try(:url)).first
  end

  def title
    Array(item.try(:title)).flatten.first
  end

  def provider
    item.try(:provider).try(:name)
  end

  def data_provider
    item.try(:source)
  end

  def intermediate_provider
    item.try(:intermediate_provider)
  end

  def contributing_institution
    [data_provider, intermediate_provider].compact.join('; ')
  end
end
