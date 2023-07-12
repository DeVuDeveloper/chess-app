require_relative "boot"

require "rails/all"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChessApp
  class Application < Rails::Application
   
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.eager_load_paths << root.join("lib")
    # config/application.rb
    config.autoload_paths += %W(#{config.root}/app/jobs)
    config.autoload_paths += %W[#{config.root}/app/operations]

    config.action_controller.default_protect_from_forgery = true

    config.active_storage.content_type_limits = {
      'audio/midi': 200.megabytes
    }



    config.i18n.available_locales = [:en, :sr]
    config.i18n.default_locale = :en
    config.active_job.queue_adapter = :sidekiq



    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
   
  end
end
