# frozen_string_literal: true

# The store presenter for this application.
class StorePresenter < SimpleDelegator
  def initialize(store, current_user)
    super(store)

    @store = store
    @current_user = current_user
  end

  def user_store?
    current_user.user_stores.exists?(store_id: id)
  end

  def name
    store.class.name
  end

  def address_with_address2
    "#{address} #{address2}".strip
  end

  def to_partial_path
    "stores/#{name.underscore}"
  end

  private

  attr_reader :store, :current_user
end
