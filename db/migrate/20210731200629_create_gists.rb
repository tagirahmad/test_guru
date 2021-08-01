# frozen_string_literal: true

class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.string :url
      t.references :user, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
