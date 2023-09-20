# frozen_string_literal: true

# The user model for this application.
class User < ApplicationRecord
  before_save :downcase_email

  has_many :user_stores
  has_many :stores, through: :user_stores, source: :store

  # Include default devise modules. Others available are: :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         authentication_keys: [:email_or_username]

  attr_accessor :email_or_username

  validates :first_name, presence: true, length: { maximum: 64 }
  validates :last_name, presence: true, length: { maximum: 64 }

  # Should be the same as the email regex in config/initializers/devise.rb
  validates :email, length: { minimum: 3, maximum: 320 }, unless: -> { email.blank? }

  validates :username, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 64 }, unless: -> { username.blank? }
  validates :username, presence: true, if: -> { username.blank? }

  validate :password_complexity, if: -> { password.present? }

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if (email_or_username = conditions.delete(:email_or_username))
        where(conditions.to_hash).where(['lower(username) = :value OR lower(email) = :value',
                                         { value: email_or_username.downcase }]).first
      else
        where(conditions.to_hash).first
      end
    end
  end

  private

  def password_complexity
    return if password.match?(/\A.*(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).*\z/)

    errors.add(:password, t('errors.messages.password_complexity'))
  end

  def downcase_email
    self.email = email.downcase
  end
end
