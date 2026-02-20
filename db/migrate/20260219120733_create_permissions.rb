class CreatePermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :app_action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
