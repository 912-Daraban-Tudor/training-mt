class CreateColumns < ActiveRecord::Migration[7.2]
  def change
    create_table :columns do |t|
      t.string :name
      # t.integer :position
      t.string :status

      t.timestamps
    end
  end
end
