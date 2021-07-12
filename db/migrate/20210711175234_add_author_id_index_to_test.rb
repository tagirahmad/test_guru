# frozen_string_literal: true

class AddAuthorIdIndexToTest < ActiveRecord::Migration[6.1]
  def change
    change_table :tests do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
    end
  end
end
