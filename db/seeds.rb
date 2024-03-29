# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  user = User.create! email: 'admin@test.com', password: 'password', password_confirmation: 'password', username: 'admin'
  game = Game.create! name: 'Test game'
  Chatroom.create! title: 'test room title', description: 'test room desc', user: user, game: game
end
