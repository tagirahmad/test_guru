# frozen_string_literal: true

class AddIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string, null: false
    add_index :users, :email, unique: true
  end
end
