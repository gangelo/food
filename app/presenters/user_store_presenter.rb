# frozen_string_literal: true

# The user store presenter to display the store associated with
# a user's user_store association.
class UserStorePresenter < StorePresenter
  def store_already_exists_modal
    {
      title: I18n.t('views.user_stores.store_already_exists_modal.title'),
      body: I18n.t('views.user_stores.store_already_exists_modal.body')
    }
  end
end
