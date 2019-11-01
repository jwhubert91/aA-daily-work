# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all

d1 = Date.new(2001, 10, 20)
d2 = Date.new(2010, 10, 20)
d3 = Date.new(2015, 6, 6)

c1 = Cat.create(name: "Polka", description: "Bomb cat!", birth_date: d1, sex: "M", color: 'grey')
c2 = Cat.create(name: "Chester Cheeto", description: "Dangerously cheesy", birth_date: d2, sex: "M", color: "brown")
c3 = Cat.create(name: "Doja Cat", description: "Definitely a cat", birth_date: d3, sex: "F", color: "black")


