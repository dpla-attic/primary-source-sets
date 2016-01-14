module SourceSetsHelper
  # Options for the Sort By menu
  def sort_options
    [['Recently added', 'recently_added'],
     ['Chronology, oldest first', 'chronology_asc'],
     ['Chronology, most recent first', 'chronology_desc']]
  end

  ##
  # Given a set of tags, return options for for a filter select element.
  # @param [Array<Tag>]
  # @return [Array<Array>]
  def tag_filter_options(tags)
    tags.map { |tag| [tag.label, tag.slug] }.unshift(['All', nil])
  end

  ##
  # Get filterable vocabularies and their associated tags.
  # Ignore any tags or vocabularies that are not associated with @source_sets.
  #
  # @param [Enumerable<SourceSet>]
  # @return [Hash<[Vocabulary] => [Enumerable<Tag>]>]
  def filters_for_sets(source_sets)
    return {} unless source_sets.present?

    Vocabulary.filterable.each_with_object({}) do |vocab, hash|
      # Get all tags associated with the vocab.
      # Ignore tags that aren't associated with any of the source_sets.
      tag_list  = vocab.tags.reject do |tag|
        tags_for_sets(source_sets).exclude?(tag)
      end

      # Return the vocab and associated tag list.
      # Note that a tag list may be empty.
      hash[vocab] = tag_list
      hash
    end
  end

  ##
  # Given a set of tags, return the slugs of those that are represented in
  # params[:tags].
  #
  # @param [Array<Tag>]
  # @return [Array<String>]
  def selected_slugs_in(tags)
    tags.select { |tag| [params[:tags]].compact.flatten.include?(tag.slug) }
        .map { |tag| tag.slug } 
  end

  ##
  # Given a set of tags, return the slugs of those tags represented in
  # params[:tags] that are NOT in the given sets of tags.
  #
  # @param [Array<Tag>]
  # @return [Array<String>]
  def selected_slugs_not_in(tags)
    [@tags].flatten.compact.reject { |tag| tags.include?(tag) }
                           .map { |tag| tag.slug }
  end

  private

  ##
  # Get all unique tags associated with @source_sets.
  # @return [Array<Tag>]
  def tags_for_sets(source_sets)
    return [] unless source_sets.present?
    source_sets.map { |set| set.tags }.flatten.uniq
  end
end
