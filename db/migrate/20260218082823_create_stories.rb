class CreateStories < ActiveRecord::Migration[7.2]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.string :status
      t.date :due_date
      t.integer :position
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
