class Column < ApplicationRecord
  has_paper_trail
  acts_as_paranoid
  has_many :board_columns, dependent: :destroy
  has_many :boards, through: :board_columns

  VALID_STATUSES = %w[icebox backlog current delivered archived]
  #de transformat in integer
  # poate folosesti before_create

  STATUSES_MAPPING = {
    VALID_STATUSES[0] => [Story::VALID_STATUSES[0]],
    VALID_STATUSES[1] => [Story::VALID_STATUSES[1]],
    VALID_STATUSES[2] => [Story::VALID_STATUSES[2], Story::VALID_STATUSES[3], Story::VALID_STATUSES[4]],
    VALID_STATUSES[3] => [Story::VALID_STATUSES[5]],
    VALID_STATUSES[4] => [Story::VALID_STATUSES[6]]
  }

  validates :name, :status, presence: true
  validates :status, inclusion: {
    in: VALID_STATUSES
  }

  def stories(current_board)
    valid_story_statuses = STATUSES_MAPPING[status] || []
    current_board.stories.where(status: valid_story_statuses)
  end
end
