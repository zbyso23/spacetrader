# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Vyčisti databázi
PlayerInventory.destroy_all
TravelRoute.destroy_all
MarketPrice.destroy_all
Player.destroy_all
User.destroy_all
Good.destroy_all
Planet.destroy_all

puts "Creating planets and moons..."

# Planety s bankami a pevnou kvalitou
mars = Planet.create!(name: 'Mars', planet_type: 'planet', has_bank: true, has_fixed_quality: true)
jupiter = Planet.create!(name: 'Jupiter', planet_type: 'planet', has_bank: true, has_fixed_quality: true)
saturn = Planet.create!(name: 'Saturn', planet_type: 'planet', has_bank: true, has_fixed_quality: true)
neptune = Planet.create!(name: 'Neptune', planet_type: 'planet', has_bank: true, has_fixed_quality: true)

# Měsíce s lichváři a variabilní kvalitou
europa = Planet.create!(name: 'Europa', planet_type: 'moon', has_bank: false, has_fixed_quality: false)
phobos = Planet.create!(name: 'Phobos', planet_type: 'moon', has_bank: false, has_fixed_quality: false)

puts "Creating goods..."

water = Good.create!(name: 'Water', description: 'Essential resource for life')
protein = Good.create!(name: 'Protein', description: 'Food source')
microchips = Good.create!(name: 'Microchips', description: 'Electronic components')
helium3 = Good.create!(name: 'Helium-3', description: 'Fusion reactor fuel')
deuterium = Good.create!(name: 'Deuterium', description: 'Heavy hydrogen isotope')

puts "Creating market prices..."

planets = [mars, jupiter, saturn, neptune, europa, phobos]
goods = [water, protein, microchips, helium3, deuterium]

planets.each do |planet|
  goods.each do |good|
    quality = planet.has_fixed_quality? ? 75 : rand(40..90)
    base_price = rand(10..100)
    
    # Měsíce mají levnější ceny
    price_modifier = planet.planet_type == 'moon' ? 0.7 : 1.0
    
    MarketPrice.create!(
      planet: planet,
      good: good,
      buy_price: (base_price * price_modifier).to_i,
      sell_price: (base_price * price_modifier * 0.7).to_i, # prodej je levnější
      quality: quality,
      stock: rand(500..2000)
    )
  end
end

puts "Creating travel routes..."

# Vytvoř všechny možné cesty (obousměrné)
planets.combination(2).each do |planet_a, planet_b|
  fuel = rand(10..50)
  time = rand(1..10)
  
  # Cesta A -> B
  TravelRoute.create!(
    from_planet: planet_a,
    to_planet: planet_b,
    fuel_cost: fuel,
    time_cost: time
  )
  
  # Cesta B -> A (stejné náklady)
  TravelRoute.create!(
    from_planet: planet_b,
    to_planet: planet_a,
    fuel_cost: fuel,
    time_cost: time
  )
end

puts "Creating test user and player..."

user = User.create!(name: 'Test Trader', email: 'trader@space.com')
player = Player.create!(
  user: user,
  name: 'Captain Nova',
  reputation: 10,
  credit: 1000,
  fuel: 100,
  current_planet: mars
)

# Dej hráči startovní inventář
PlayerInventory.create!(player: player, good: water, quantity: 10, quality: 50)
PlayerInventory.create!(player: player, good: protein, quantity: 5, quality: 50)

puts "Seeds completed!"
puts "Planets: #{Planet.count}"
puts "Goods: #{Good.count}"
puts "Market Prices: #{MarketPrice.count}"
puts "Travel Routes: #{TravelRoute.count}"
puts "Players: #{Player.count}"