require 'kramdown'

module MarkdownHelper
  def render_markdown(content)
    Kramdown::Document.new(content).to_html.html_safe
  end
end

