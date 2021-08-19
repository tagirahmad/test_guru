# frozen_string_literal: true

class TestPassage < ApplicationRecord
  SUCCESS_SCORE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_question

  def accept!(answer_ids)
    return if answer_ids.nil?

    self.correct_question += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def question_position
    test.questions.find_index(current_question) + 1
  end

  def remaining_time
    (test.time - (Time.now - created_at).seconds).to_i
  end

  def result_score
    (self.correct_question.to_f / test_questions_count) * 100
  end

  def passed?
    result_score >= SUCCESS_SCORE
  end

  def test_questions_count
    test.questions.count
  end

  private

  def set_question
    self.current_question = if current_question.present?
                              next_question
                            else
                              test.questions.first
                            end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def correct_user_answers_count(answer_ids)
    correct_answers.where(id: answer_ids).count
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
