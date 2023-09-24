# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "いきものとくらす",
  email: "admin@example.jp",
  introduction: "特に猫が好きな人です",
  password: "ikimonotokurasu202307",
  password_confirmation: "ikimonotokurasu202307",
  admin: true
)