CATEGORIES = ["category 1", "category 2", "category 3", "category 4", "category 5"]

5.times do |index|
  user = User.create(name: "User #{index + 1}")

  category = Category.create(title: "#{CATEGORIES[index]}")

  test = Test.create(title: "Test #{index + 1}", level: index, category_id: category.id, author_id: user.id)
  test.users << user

  question = Question.new(body: "Question body #{index + 1}", test_id: test.id)

  4.times do |i|
    question.answers.build(body: "Answer body #{i + 1}", question_id: question.id, is_correct_answer: i == 1 ? true : false )
  end

  question.save
end
