# encoding: utf-8
require_relative "boot"
require "rails/all"

# Disabilitiamo completamente SolidCache e SolidQueue
# per usare solo PostgreSQL come DB principale

Bundler.require(*Rails.groups)

module BoxTracker
  class Application < Rails::Application
    config.load_defaults 8.1

    # ✅ Solo Postgres, nessun database separato
    config.active_job.queue_adapter = :async
    config.cache_store = :memory_store

    # ✅ Impostazioni base
    config.time_zone = "Rome"
    config.i18n.available_locales = [:en, :it]
    config.i18n.default_locale = :it
<<<<<<< HEAD


    # 🔹 Usa PostgreSQL (nessun database secondario)
    config.active_record.database_selector = nil
    config.active_record.database_resolver = nil
    config.active_record.database_resolver_context = nil

    # 🔹 Usa ActiveJob in modalità asincrona (no database "queue")
    config.active_job.queue_adapter = :async

    # 🔹 Disabilita qualsiasi richiesta di connessione a database "queue"
    config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time]
=======
>>>>>>> 3942f33 (Fix: rimozione SolidCache/SolidQueue e configurazione stabile per produzione)
  end
end

