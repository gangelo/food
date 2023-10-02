# frozen_string_literal: true

# The user_store model for this application.
class UserStore < ApplicationRecord
  belongs_to :user
  belongs_to :store

  accepts_nested_attributes_for :store

  scope :where_case_insensitive_for, lambda { |user, store_name:, zip_code:|
    user.stores.where(id: Store.where_name_and_zip_case_insensitive(store_name, zip_code).pluck(:id))
  }

  validate :user_store_not_already_added, if: -> { store.present? }

  class << self
    def store_exists?(user, store_name:, zip_code:)
      store_for(user, store_name: store_name, zip_code: zip_code).present?
    end

    def store_for(user, store_name:, zip_code:)
      return nil if user.stores.none?

      user.stores.where(id: Store.where_name_and_zip_case_insensitive(store_name, zip_code).pluck(:id)).first
    end
  end

  private

  def user_store_not_already_added
    return unless UserStore.store_exists?(user, store_name: store.store_name, zip_code: store.zip_code)

    errors.add(:base, I18n.t('activerecord.errors.models.user_store.already_added'))
  end
end
