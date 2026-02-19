class Board < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  belongs_to :user

  has_many :stories, dependent: :destroy

  has_many :board_columns, dependent: :destroy
  has_many :columns, through: :board_columns

  validates :user_id, :name, presence: true

  scope :active, -> { where(archived: false) }
end
