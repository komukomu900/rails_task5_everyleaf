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
label = ["経理","社外","経営","調達","営業1","営業2","営業3","技術1","技術2","技術3"]
label.each do |n|
  label = "#{n}"
  Label.create!(label: label)
end