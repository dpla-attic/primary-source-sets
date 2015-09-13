module ApplicationHelper

  ##
  # @param String text A markdown formatted String
  # @return String An HTML representation of the markdown string given in 'text'
  # @raise TypeError if @param is not a String
  def markdown(text)
    options = { autolink: true, footnotes: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(text)
      .html_safe
  end

  def source_name(source)
    source.name.present? ? source.name : source.aggregation
  end
end
