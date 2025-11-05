# encoding: utf-8
require 'faker'

puts "Pulizia tabelle..."
Movement.delete_all
Item.delete_all
Box.delete_all
User.delete_all

puts "Creo utente..."
user = User.create!(
  email: 'demo@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  role: 'user'
)

puts "Creo box (con annidamento)..."
root1 = user.boxes.create!(code: 'A001', name: 'Casa',   location: 'Battipaglia', description: 'Box principale Casa')
root2 = user.boxes.create!(code: 'A002', name: 'Garage', location: 'Battipaglia', description: 'Box principale Garage')

# figli
cucina   = user.boxes.create!(code: 'A001-1', name: 'Cucina',   location: 'Casa',   description: 'Sottobox cucina', parent: root1)
salotto  = user.boxes.create!(code: 'A001-2', name: 'Salotto',  location: 'Casa',   description: 'Sottobox salotto', parent: root1)
attrezzi = user.boxes.create!(code: 'A002-1', name: 'Attrezzi', location: 'Garage', description: 'Sottobox attrezzi', parent: root2)

boxes = [root1, root2, cucina, salotto, attrezzi]

puts "Creo oggetti e movimenti..."
10.times do |i|
  b = boxes.sample
  item = Item.create!(
    box: b,
    name: "Oggetto #{i+1}",
    code: "ITM#{1000 + i}",
    category: ['Ferramenta', 'Cucina', 'Elettronica'].sample,
    quantity: rand(1..5),
    position: ['Ripiano 1', 'Ripiano 2', 'Cassetto', 'Scatola'].sample,
    notes: Faker::Lorem.sentence(word_count: 6),
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )

  # 1–3 movimenti per oggetto
  rand(1..3).times do
    from_b = boxes.sample
    to_b   = boxes.sample
    Movement.create!(
      item: item,
      user: user,
      from_box: from_b,
      to_box: to_b,
      action: %w[moved loaned returned].sample,
      notes: Faker::Lorem.sentence(word_count: 4),
      created_at: rand(10).days.ago + rand(0..23).hours
    )
    # Aggiorna box corrente dell'oggetto (simulazione spostamento)
    item.update!(box: to_b)
  end
end

puts "FATTO. Utente: demo@example.com / password123"
