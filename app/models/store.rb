# frozen_string_literal: true

# The store model for this application.
class Store < ApplicationRecord
  before_save :before_save_edits

  belongs_to :state

  has_many :user_stores
  has_many :users, through: :user_stores, source: :user

  validates :store_name, :address, :city, presence: true, length: { maximum: 64 }
  validates :address2, length: { maximum: 64 }, allow_blank: true

  # Validates :zip_code which could be 5 digits with optional 4 digit extension.
  validates :zip_code, format: { with: /\A\d{5}(-\d{4})?\z/ }

  # Validates uniqueness of store_name within a zip code, case insensitive
  validates :store_name, uniqueness: { scope: :zip_code, case_sensitive: false }

  def before_save_edits
    self.store_name = store_name.titleize
    self.address = address.titleize
    self.address2 = address2.titleize if address2.present?
  end
end
