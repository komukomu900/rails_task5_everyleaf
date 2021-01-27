# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
    name = "test#{n}"
    email = "test#{n}@test.com"
    password = "test"
    User.create!(
                name: name,
                email: email,
                password: password,
                password_confirmation: password
                )
end
name = "admin"
email = "admin@admin.com"
password = "admin"
admin = "true"
User.create!(
  name: name,
  email: email,
  password: password,
  password_confirmation: password,
  admin: admin
)
5.times do |n|
  label = " ラベル#{n} "
  Label.create!(label: label)
end