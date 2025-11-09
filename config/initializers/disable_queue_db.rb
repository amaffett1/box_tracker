# encoding: utf-8
# ✅ Disabilita il supporto per database multipli (queue, cable, etc.)
# Rails 8.1 a volte crea connessioni "queue" o "cable" anche se non configurate.
# Questo initializer forza l'uso del solo database principale.

Rails.application.config.after_initialize do
  begin
    # Rimuove le configurazioni aggiuntive di ActiveRecord
    if defined?(ActiveRecord::Base)
      if ActiveRecord::Base.respond_to?(:connection_handlers)
        ActiveRecord::Base.connection_handlers = { writing: ActiveRecord::Base.default_connection_handler }
      end

      # Svuota la mappa di "shard_category_to_connection_name" se presente
      if ActiveRecord::Base.instance_variable_defined?(:@shard_category_to_connection_name)
        ActiveRecord::Base.remove_instance_variable(:@shard_category_to_connection_name) rescue nil
      end
      ActiveRecord::Base.instance_variable_set(:@shard_category_to_connection_name, {})
    end

    Rails.logger.info "✅ Disabilitato supporto per database multipli (queue/cable)."
  rescue => e
    Rails.logger.warn "⚠️ Errore nel disattivare i DB multipli: #{e.message}"
  end
end

