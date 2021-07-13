# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  scope :correct_answer, -> { where(is_correct_answer: true) }

  validate :check_answers_count, on: :create

  def check_answers_count
    errors.add(:base, 'Answers count > 4') if question.answers.count == 4
  end
end
