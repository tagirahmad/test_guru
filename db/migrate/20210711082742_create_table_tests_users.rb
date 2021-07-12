# frozen_string_literal: true

class CreateTableTestsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :tests_users do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :test, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
