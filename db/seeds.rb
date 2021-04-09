# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


users = [
  mal = User.find_or_create_by(first_name: "Malcolm", last_name: "Reynolds", email: "malcolm@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  zoe = User.find_or_create_by(first_name: "Zoë", last_name: "Washburne", email: "zoe@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  wash = User.find_or_create_by(first_name: "Hoban", last_name: "Washburne", email: "wash@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  inara = User.find_or_create_by(first_name: "Inara", last_name: "Serra", email: "inara@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  river = User.find_or_create_by(first_name: "River", last_name: "Tam", email: "river@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  simon = User.find_or_create_by(first_name: "Simon", last_name: "Tam", email: "simon@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  book = User.find_or_create_by(first_name: "Shepherd", last_name: "Book", email: "book@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  kaylee = User.find_or_create_by(first_name: "Kaylee", last_name: "Frye", email: "kaylee@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end,
  jayne = User.find_or_create_by(first_name: "Jayne", last_name: "Cobb", email: "jayne@firefly.net") do |user|
    user.password = "serenity"
    user.password_confirmation = "serenity"
  end
]

users.permutation(2) do |pair|
  FriendshipRequest.find_or_create_by(user_id: pair[0].id, requested_friend_id: pair[1].id)
end
