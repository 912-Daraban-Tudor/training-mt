class CreateBoardColumns < ActiveRecord::Migration[7.2]
  def change
    create_table :board_columns do |t|
      t.references :board, null: false, foreign_key: true
      t.references :column, null: false, foreign_key: true
      t.integer :column_position


      t.timestamps
    end
  end
end
