# frozen_string_literal: true

# The user model for this application.
class User < ApplicationRecord
  before_save :downcase_email

  # Include default devise modules. Others available are: :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  validates :first_name, length: { minimum: 1, maximum: 64 }
  validates :last_name, length: { minimum: 1, maximum: 64 }
  # Should be the same as the email regex in config/initializers/devise.rb
  validates :email, length: { minimum: 3, maximum: 320 }
  validates :username, uniqueness: true, length: { minimum: 4, maximum: 64 }
  # Should be the same as the password length in config/initializers/devise.rb
  validates :password, length: { minimum: 8, maximum: 128 }
  validates :password_confirmation, presence: true, on: :create
  validate :password_complexity, on: :create, if: -> { password.present? }

  private

  def password_complexity
    return if password.match?(/\A.*(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).*\z/)

    errors.add(:password, t('errors.messages.password_complexity'))
  end

  def downcase_email
    self.email = email.downcase
  end
end
