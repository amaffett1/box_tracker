# encoding: utf-8

puts "Pulizia database..."
Movement.delete_all
Item.delete_all
Box.delete_all
User.delete_all

puts "Creazione utenti..."
u1 = User.create!(email: "alessandro@example.com", password: "password", role: "admin")
u2 = User.create!(email: "mario@example.com", password: "password", role: "operator")

puts "Creazione box principali..."
garage = Box.create!(code: "A001", name: "Garage", location: "Casa", description: "Box garage", user: u1)
cucina = Box.create!(code: "A002", name: "Cucina", location: "Casa", description: "Box cucina", user: u1)
studio  = Box.create!(code: "A003", name: "Studio", location: "Casa", description: "Box studio", user: u2)

puts "Creazione sotto-box..."
utensili = Box.create!(code: "A001-1", name: "Utensili", location: "Garage", description: "Attrezzi vari", parent_box: garage, user: u1)
viti     = Box.create!(code: "A001-2", name: "Viti e bulloni", location: "Garage", description: "Ferramenta piccola", parent_box: garage, user: u1)
spezie   = Box.create!(code: "A002-1", name: "Spezie", location: "Cucina", description: "Cassetto spezie", parent_box: cucina, user: u1)

puts "Creazione oggetti..."
items = []
10.times do |i|
  items << Item.create!(
    name: "Oggetto #{i + 1}",
    code: "IT#{100 + i}",
    description: "Descrizione oggetto #{i + 1}",
    box: [garage, utensili, viti, spezie, studio].sample,
    quantity: rand(1..5)
  )
end

puts "Creazione movimenti casuali..."
10.times do
  item = items.sample
  from_box = item.box
  to_box = [garage, cucina, studio, utensili, viti].sample
  Movement.create!(
    item: item,
    user: [u1, u2].sample,
    from_box: from_box,
    to_box: to_box,
    action: ["moved", "loaned", "returned"].sample,
    notes: "Test movimento per #{item.name}"
  )
end

puts "✅ Database popolato con successo!"
