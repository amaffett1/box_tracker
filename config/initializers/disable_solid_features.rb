# encoding: utf-8
# ✅ Disattiva SolidCache e SolidQueue in produzione
Rails.application.config.after_initialize do
  if defined?(ActiveRecord::Base.configurations)
    Rails.logger.info "✅ Disattivazione forzata SolidCache e SolidQueue"

    # Evita di cercare database separati (cache, queue, cable)
    ActiveRecord::Base.configurations.configs_for(env_name: "production").each do |config|
      if %w[cache queue cable].include?(config.name.to_s)
        Rails.logger.info "Rimosso database secondario: #{config.name}"
      end
    end
  end

  # Imposta un adapter sicuro e locale
  Rails.application.config.cache_store = :memory_store
  Rails.application.config.active_job.queue_adapter = :async

  # Se esistono le configurazioni SolidCache/SolidQueue, annullale
  if defined?(Rails.application.config.solid_cache)
    Rails.application.config.solid_cache = nil
  end

  if defined?(Rails.application.config.solid_queue)
    Rails.application.config.solid_queue = nil
  end
end

