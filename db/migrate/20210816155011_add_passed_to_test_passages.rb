# frozen_string_literal: true

class AddPassedToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :passed, :boolean, default: false, null: false
  end
end
