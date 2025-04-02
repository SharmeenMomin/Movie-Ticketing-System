class Admin < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  before_destroy :prevent_admin_deletion

  private

  def prevent_admin_deletion
    throw(:abort)
  end

  before_update :prevent_critical_update

  def prevent_critical_update
    if self.username_changed?
      errors.add(:username, "cannot be changed.")
      throw :abort
    end
  end

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions.to_h).where(["username = :value OR email = :value", { value: login }]).first
  end
end
