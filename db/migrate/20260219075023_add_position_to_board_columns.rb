class AddPositionToBoardColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :board_columns, :column_position, :integer
  end
end
