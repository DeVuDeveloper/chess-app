
module ApplicationHelper

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "error-message" do
        object.errors.full_messages.to_sentence.capitalize
      end
    end
  end

  def nested_dom_id(*args)
    args.map { |arg| arg.respond_to?(:to_key) ? dom_id(arg) : arg }.join("_")
  end


  def render_markdown(content)
    Kramdown::Document.new(content).to_html.html_safe
  end

  def highlight_code(code, language = 'html')
    formatter = Rouge::Formatters::HTMLLegacy.new(css_class: 'highlight')
    lexer = Rouge::Lexer.find(language) || Rouge::Lexers::PlainText
    highlighted_code = formatter.format(lexer.lex(code))
    "<pre>#{highlighted_code}</pre>".html_safe
  end

  def render_markdown_with_code_highlighting(content)
    highlighted_content = content.gsub(/```([\s\S]*?)```/m) do
      code_block = $1
      "<pre class='dark'>#{code_block}</pre>"
    end

    render_markdown(highlighted_content)
  end
end