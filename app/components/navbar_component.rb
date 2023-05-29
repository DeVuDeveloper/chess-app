class NavbarComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def active_link_to(name = nil, options = nil, html_options = nil, &block)
    if current_page?(options)
      active_class = html_options[:active_class] ? html_options[:active_class] : 'bg-red-400'
      html_options[:class] << "#{html_options[:class]} #{active_class}"
    end

    link_to(name, options, html_options, &block)
  end
end