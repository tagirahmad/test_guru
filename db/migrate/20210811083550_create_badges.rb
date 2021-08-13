# frozen_string_literal: true

class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image, null: false
      t.integer :achievement_type
      t.references :category, null: false, foreign_key: true
      t.references :test,     null: false, foreign_key: true

      t.timestamps
    end
  end
end
