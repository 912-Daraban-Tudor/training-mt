class AppAction < ApplicationRecord

  ALLOWED_ACTIONS = %w[
    view_board edit_board
    view_story edit_story
  ]

  has_many :permissions, dependent: :destroy
  # has_many :roles, through: :permissions - no dependency inversion

  validates :name, presence: true, inclusion: { in: ALLOWED_ACTIONS }
end
