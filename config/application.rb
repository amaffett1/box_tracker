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
    # 🔹 Usa PostgreSQL per Active Record
    config.active_record.schema_format = :sql

    # 🔹 Usa ActiveJob async (no database per queue)
    config.active_job.queue_adapter = :async

    # 🔹 Prepara eventuali WebSocket, ma senza Redis
    config.action_cable.disable_request_forgery_protection = true
  end
end
