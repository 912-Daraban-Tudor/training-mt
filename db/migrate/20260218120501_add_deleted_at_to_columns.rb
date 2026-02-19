class AddDeletedAtToColumns < ActiveRecord::Migration[7.2]
  def change
    add_column :columns, :deleted_at, :datetime
    add_index :columns, :deleted_at
  end
end
