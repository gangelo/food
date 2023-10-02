# frozen_string_literal: true

# The user store presenter to display the store associated with
# a user's user_store association.
class UserStorePresenter < StorePresenter
  def user_store_exists?
    return false unless store.store_name.present? && store.zip_code.present?

    UserStore.store_exists?(user, store_name: store.store_name, zip_code: store.zip_code)
  end

  def store_already_exists_modal
    {
      title: I18n.t('views.user_stores.store_already_exists_modal.title'),
      body: I18n.t('views.user_stores.store_already_exists_modal.body'),
      primary_button: I18n.t('views.user_stores.store_already_exists_modal.buttons.primary'),
      secondary_button: I18n.t('views.user_stores.store_already_exists_modal.buttons.secondary')
    }
  end
end
