class User < ApplicationRecord
  has_paper_trail
  acts_as_paranoid
  has_many :boards

  validates :name, :email, presence: true
end
