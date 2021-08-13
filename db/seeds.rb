# frozen_string_literal: true

CATEGORIES = %w[Backend Ruby JS Java Frontend].freeze
EMAILS = %w[test@gmail.com test2@gmail.com test3@gmail.com test4@gmail.com test5@gmail.com].freeze
LEVELS = { 0 => :simple, 1 => :simple, 2 => :medium, 4 => :medium, 5 => :difficult }.freeze

User.create!(first_name: 'Admin',
             last_name: 'Admin',
             email: ENV['SENDER_EMAIL'],
             password: 'qwerty',
             type: 'Admin')

5.times do |index| # rubocop:disable Metrics/BlockLength
  user = User.create!(first_name: "User #{index + 1}",
                      last_name: 'last name',
                      email: EMAILS[index],
                      password: 'qwerty')

  category = Category.create!(title: (CATEGORIES[index]).to_s)

  test = Test.create!(title: "Test #{CATEGORIES[index]}", level: index, category_id: category.id, author_id: user.id)
  test.users << user

  Badge.create!(name: "You passed all test of #{category.title} category",
                image: 'link',
                test_id: test.id,
                category_id: category.id,
                achievement_type: 0)

  Badge.create!(name: "You passed the #{test.title} from first attempt",
                image: 'link',
                test_id: test.id,
                category_id: category.id,
                achievement_type: 1)

  Badge.create!(name: "You passed all tests of the #{LEVELS[test.level]} level",
                image: 'link',
                test_id: test.id,
                category_id: category.id,
                achievement_type: 2)

  4.times do
    question = Question.create!(body: "Question body #{index + 1}", test_id: test.id)
    4.times do |k|
      question.answers << Answer.create!(body: "Answer body #{k + 1}", question_id: question.id, correct: k == 1)
    end
  end
end
