# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Cat.delete_all
CatRentalRequest.delete_all

# For testing game/user stuff

test_users = User.create([
  {user_name: "CatLady", password: "password"},
  {user_name: "SomeGuy", password: "password"},
  {user_name: "Catnapper", password: "gimmeyocats"},
])

test_cats = Cat.create([
  {name: "Accomplice", sex: "M", age: 99, birth_date: "2013-10-11", color: "white", user_id: test_users[2].id},
  {name: "Mittens", sex: "F", age: 4, birth_date: "2009-10-29", color: "white", user_id: test_users[0].id},
  {name: "Bigglesworth", sex: "M", age: 59, birth_date: "1955-10-25", color: "gray", user_id: test_users[0].id},
  {name: "El Gato Diablo", sex: "M", age: 666, birth_date: "1347-10-22", color: "black", user_id: test_users[0].id},
  {name: "Sourpus", sex: "F", age: 5, birth_date: "2008-10-21", color: "magenta", user_id: test_users[0].id},
  {name: "Gandalf", sex: "M", age: 7, birth_date: "2007-10-05", color: "gray", user_id: test_users[0].id},
  {name: "Schrodinger", sex: "F", age: 9, birth_date: "2004-10-03", color: "white", user_id: test_users[1].id},
])

test_requests = CatRentalRequest.create([
  {cat_id: test_cats[0].id, start_date:"2013-11-10", end_date: "2013-11-11"}
])
