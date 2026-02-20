class CreateAppActions < ActiveRecord::Migration[7.2]
  def change
    create_table :app_actions do |t|
      t.string :name

      t.timestamps
    end
  end
end
