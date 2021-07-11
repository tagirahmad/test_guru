class AddAuthorIdIndexToTest < ActiveRecord::Migration[6.1]
  def change
    change_table :tests do |t|
      t.integer :author_id, null: false

      add_index :tests, :author_id
    end
  end
end
