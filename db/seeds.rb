# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CATEGORIES = ["category 1", "category 2", "category 3", "category 4", "category 5"]

5.times do |index|
  User.create(name: "User #{index + 1}")
end

5.times do |index|
  Category.create(title: "#{CATEGORIES[index]}")
end

5.times do |index|
  Test.create(title: "Test #{index + 1}", level: index, category_id: index + 1)
end

5.times do |index|
  Question.create(body: "Question body #{index + 1}", test_id: index + 1)
end

5.times do |index|
  Answer.create(body: "Answer body #{index + 1}", question_id: index + 1)
end