class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_paper_trail
  acts_as_paranoid
  has_many :boards
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  validates :name, :email, presence: true

  after_create :assign_default_role

  def admin?
    roles.exists?(name: 'Admin')
  end

  def user_permissions
    @user_permissions ||= roles.joins(:app_actions).pluck('app_actions.name').uniq
  end

  def can?(action_name)
    return true if admin?

    unless AppAction::ALLOWED_ACTIONS.include?(action_name)
      raise ArgumentError, "System Error: '#{action_name}' is not defined in AppAction::ALLOWED_ACTIONS"
    end

    user_permissions.include?(action_name)
  end

  private

  def assign_default_role
    default_role = Role.find_or_create_by(name: 'Member')
    self.roles << default_role
  end
end
