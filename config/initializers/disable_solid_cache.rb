# encoding: utf-8
# ✅ Disabilita completamente SolidCache e SolidQueue in produzione
#    per usare solo PostgreSQL come database principale.

Rails.application.config.after_initialize do
  if defined?(SolidCache)
    Rails.logger.info "🧹 Disabilitazione SolidCache in corso..."
    begin
      SolidCache::Engine.config.solid_cache = ActiveSupport::OrderedOptions.new
      SolidCache::Engine.config.solid_cache.connects_to = nil
    rescue => e
      Rails.logger.warn "⚠️ Non è stato possibile disattivare SolidCache: #{e.message}"
    end
  end

  if defined?(SolidQueue)
    Rails.logger.info "🧹 Disabilitazione SolidQueue in corso..."
    begin
      SolidQueue::Engine.config.solid_queue = ActiveSupport::OrderedOptions.new
      SolidQueue::Engine.config.solid_queue.connects_to = nil
    rescue => e
      Rails.logger.warn "⚠️ Non è stato possibile disattivare SolidQueue: #{e.message}"
    end
  end
end

