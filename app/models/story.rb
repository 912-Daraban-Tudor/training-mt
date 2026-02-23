class Story < ApplicationRecord
  has_paper_trail
  acts_as_paranoid
  belongs_to :associable, polymorphic: true

  VALID_STATUSES = %w[icebox backlog pending in_progress finished delivered archived]

  # validates :title, :status, presence: true
  #
  # validates :status, inclusion: {
  #   in: VALID_STATUSES
  # }

  self.inheritance_column = :type
  attr_writer :type

  # de migrat dependenta de user sau
  # de migrat doar un autor, id-ul luat din board

end
