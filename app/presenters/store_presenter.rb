# frozen_string_literal: true

# The store presenter for this application.
class StorePresenter < Presenter
  # Returns true if the current user has an association with
  # the store that this presenter represents.
  def user_store?
    user.user_stores.exists?(store_id: id)
  end

  def display_address
    "#{address} #{address2}".strip
  end

  def display_state
    "#{state.state_name} (#{state.postal_abbreviation})"
  end

  def display_full_address
    "#{display_address}, #{display_state} #{zip_code}"
  end
end
