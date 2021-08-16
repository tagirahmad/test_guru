# frozen_string_literal: true

CATEGORIES = %w[Backend Ruby JS Java Frontend].freeze
EMAILS = %w[test@gmail.com test2@gmail.com test3@gmail.com test4@gmail.com test5@gmail.com].freeze
LEVELS = { 0 => :simple, 1 => :simple, 2 => :medium, 4 => :medium, 5 => :difficult }.freeze

User.create!(first_name: 'Admin',
             last_name: 'Admin',
             email: ENV['SENDER_EMAIL'],
             password: 'qwerty',
             type: 'Admin')

5.times do |index|
  user = User.create!(first_name: "User #{index + 1}",
                      last_name: 'last name',
                      email: EMAILS[index],
                      password: 'qwerty')

  category = Category.create!(title: (CATEGORIES[index]).to_s)

  test = Test.create!(title: "Test #{CATEGORIES[index]}", level: index, category_id: category.id, author_id: user.id)
  test.users << user

  Badge.create!(name: "You passed all tests of #{CATEGORIES[index]} category",
                image: 'link',
                rule: 'all_tests_of_category',
                parameter: CATEGORIES[index])

  Badge.create!(name: 'You passed test from first attempt',
                image: 'link',
                rule: 'first_attempt',
                parameter: 'first_attempt')

  Badge.create!(name: "You passed test of the #{LEVELS[test.level]} level",
                image: 'link',
                rule: 'all_tests_of_level',
                parameter: test.level)

  4.times do
    question = Question.create!(body: "Question body #{index + 1}", test_id: test.id)
    4.times do |k|
      question.answers << Answer.create!(body: "Answer body #{k + 1}", question_id: question.id, correct: k == 1)
    end
  end
end
