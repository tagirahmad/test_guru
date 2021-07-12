# frozen_string_literal: true

class AddIsCorrectAnswerToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :is_correct_answer, :boolean, null: false
  end
end
