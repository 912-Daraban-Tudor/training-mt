class AddArchivedToBoards < ActiveRecord::Migration[7.2]
  def change
    add_column :boards, :archived, :boolean, default: false
  end
end
