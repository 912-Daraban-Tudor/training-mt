class Story < ApplicationRecord
  has_paper_trail
  acts_as_paranoid
  belongs_to :board

  VALID_STATUSES = %w[icebox backlog pending in_progress finished delivered archived]

  validates :title, :status, :due_date, :board_id, presence: true

  validates :status, inclusion: {
    in: VALID_STATUSES
  }
  # de migrat dependenta de user sau
  # de migrat doar un autor, id-ul luat din board
end
