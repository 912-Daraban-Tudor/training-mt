class Permission < ApplicationRecord
  belongs_to :role
  belongs_to :app_action

  validates :app_action_id, uniqueness: {
    scope: :role_id
  }
end
