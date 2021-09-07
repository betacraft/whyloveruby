# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

10.times do
  User.create(name: Faker::Name.unique.name, image: Faker::LoremFlickr.image)
end

21.times do
  Letter.create(user_id: User.pluck(:id).sample, description: Faker::Markdown.headers)
end
