# frozen_string_literal: true

# The store model for this application.
class Store < ApplicationRecord
  include ArchivableConcern

  before_save :before_save_edits

  attr_reader :non_unique_store_id

  scope :where_name_and_zip_case_insensitive, lambda { |store_name, zip_code|
    where('LOWER(store_name) = LOWER(?) AND zip_code = ?', store_name, zip_code)
  }

  belongs_to :state

  has_many :user_stores
  has_many :users, through: :user_stores, source: :user

  validates :store_name, :address, :city, presence: true, length: { maximum: 64 }
  validates :address2, length: { maximum: 64 }, allow_blank: true

  # Validates :zip_code which could be 5 digits with optional 4 digit extension.
  validates :zip_code, format: { with: /\A\d{5}(-\d{4})?\z/ }

  validate :store_name_and_zip_code_uniqueness, if: -> { store_name_and_zip_code? }

  def non_unique_store?
    !unique_store?
  end

  def unique_store?
    return true unless store_name_and_zip_code?

    store = self.class.where_name_and_zip_case_insensitive(store_name, zip_code).first
    return true unless store

    # This attribute (id) will be populated with the id of the
    # store that already exists with the same name and zip code.
    self.non_unique_store_id = store.id unless store.id == id

    non_unique_store_id.nil?
  end

  private

  attr_writer :non_unique_store_id

  def store_name_and_zip_code_uniqueness
    return true if unique_store?

    errors.add(:base, I18n.t('activerecord.errors.models.store.already_exists'))
  end

  def store_name_and_zip_code?
    store_name.present? && zip_code.present?
  end

  def before_save_edits
    store_name[0] = store_name[0].upcase
    self.address = address.titleize
    self.address2 = address2.titleize if address2.present?
  end
end
