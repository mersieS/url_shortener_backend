# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(username: 'Salo', email: 'salo@gmail.com', password: 'password')

Url.create(name: 'Faker URL', original_url: Faker::Internet.url, user_id: User.find_by(email: 'salo@gmail.com').id)

200.times do
  Click.create!(ip_address: Faker::Internet.ip_v4_address, url_id: url.id, browser: 'Opera', country: Faker::Address.country, city: Faker::Address.city, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
end