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

  Category.create(title: "#{CATEGORIES[index]}")

  Test.create(title: "Test #{index + 1}", level: index, category_id: Category.pluck(:id).sample, user_id: User.pluck(:id).sample)

  Question.create(body: "Question body #{index + 1}", test_id: Test.pluck(:id).sample)

  Answer.create(body: "Answer body #{index + 1}", question_id: Question.pluck(:id).sample)
end