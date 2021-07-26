# frozen_string_literal: true

CATEGORIES = ['category 1', 'category 2', 'category 3', 'category 4', 'category 5'].freeze
EMAILS = %w[test@gmail.com test2@gmail.com test3@gmail.com test4@gmail.com test5@gmail.com].freeze

5.times do |index|
  user = User.create!(first_name: "User #{index + 1}",
                      last_name: 'last name',
                      email: EMAILS[index],
                      password: 'qwerty')

  category = Category.create!(title: (CATEGORIES[index]).to_s)

  test = Test.create!(title: "Test #{index + 1}", level: index, category_id: category.id, author_id: user.id)
  test.users << user

  question = Question.create!(body: "Question body #{index + 1}", test_id: test.id)

  4.times do |i|
    question.answers << Answer.create!(body: "Answer body #{i + 1}", question_id: question.id, correct: i == 1)
  end
end
