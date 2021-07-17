# frozen_string_literal: true

module QuestionsHelper
  def question_header(question)
    "#{question.new_record? ? 'Create' : 'Edit'} #{question.test.title} question"
  end
end
