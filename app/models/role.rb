class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles

  has_many :permissions, dependent: :destroy
  has_many :app_actions, through: :permissions

end
