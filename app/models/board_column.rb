class BoardColumn < ApplicationRecord
  belongs_to :board
  belongs_to :column

  validates :column_id, uniqueness: {
    scope: :board_id
  }

  before_create :set_default_position
  def set_default_position
    highest_pos = BoardColumn.where(board_id: self.board_id).maximum(:column_position) || 0
    self.column_position = highest_pos + 1
  end
end
