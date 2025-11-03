# encoding: utf-8
# lib/tasks/debug_test.rake

namespace :debug do
  desc "Verifica relazioni e dati principali prima del commit"
  task check: :environment do
    puts "\n🔍 TEST RELAZIONI — #{Time.now.strftime('%d/%m/%Y %H:%M:%S')}"

    puts "\nUtenti: #{User.count}"
    User.all.each do |u|
      puts "  👤 #{u.email} (#{u.role}) → Box: #{u.boxes.count}, Items: #{u.items.count}, Movimenti: #{u.movements.count}"
    end

    puts "\nBox totali: #{Box.count}"
    Box.all.each do |b|
      sub = b.sub_boxes.count
      items = b.items.count
      parent = b.parent_box&.name || "-"
      puts "  📦 #{b.name} (Parent: #{parent}) → Sotto-box: #{sub}, Oggetti: #{items}"
    end

    puts "\nItems totali: #{Item.count}"
    Item.all.limit(5).each do |i|
      puts "  🧰 #{i.name} (Box: #{i.box&.name || 'Nessuna'})"
    end

    puts "\nMovimenti totali: #{Movement.count}"
    Movement.all.limit(5).each do |m|
      puts "  🔄 #{m.item.name} | #{m.action} | da #{m.from_box&.name || '?'} → #{m.to_box&.name || '?'} | #{m.user.email}"
    end

    chart_data = Movement.group("DATE(created_at)").count
    puts "\n📈 Dati per grafico (movimenti per giorno):"
    chart_data.each { |d, c| puts "  #{d} → #{c}" }

    puts "\n✅ Test completato. Se tutti i numeri sopra sono coerenti, puoi procedere al commit."
  end
end
