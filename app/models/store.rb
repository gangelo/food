# frozen_string_literal: true

# The store model for this application.
class Store < ApplicationRecord
  before_save :before_save_edits

  belongs_to :state

  has_many :user_stores
  has_many :users, through: :user_stores, source: :user

  validates :state_name, :street1, :city, presence: true, length: { maximum: 64 }
  validates :street2, length: { maximum: 64 }, allow_blank: true

  # Validates :zip_code which could be 5 digits with optional 4 digit extension.
  validates :zip_code, format: { with: /\A\d{5}(-\d{4})?\z/ }

  # Validates uniqueness of state_name within a zip code, case insensitive
  validates :state_name, uniqueness: { scope: :zip_code, case_sensitive: false }

  def before_save_edits
    self.state_name = state_name.titleize
    self.street1 = street1.titleize
    self.street2 = street2.titleize if street2.present?
  end
end
