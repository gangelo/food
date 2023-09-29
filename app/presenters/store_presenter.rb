# frozen_string_literal: true

# The store presenter for this application.
class StorePresenter < Presenter
  # Returns true if the current user has an association with
  # the store that this presenter represents.
  def user_store?
    user.user_stores.exists?(store_id: id)
  end

  def address_with_address2
    "#{address} #{address2}".strip
  end
end
