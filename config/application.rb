require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mariva
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Europe/Moscow"
    # config.eager_load_paths << Rails.root.join("extras")
    #
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    config.i18n.default_locale = :ru
    config.active_job.queue_adapter = :sidekiq
  end
end
