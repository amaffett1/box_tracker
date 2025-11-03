require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# config/application.rb
module BoxTracker
  class Application < Rails::Application
    config.load_defaults 8.1

    config.encoding = "utf-8"
  end
end
