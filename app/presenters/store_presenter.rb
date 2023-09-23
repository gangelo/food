# frozen_string_literal: true

# The store presenter for this application.
class StorePresenter < SimpleDelegator
  def initialize(store, current_user)
    super(store)

    @store = store
    @current_user = current_user
  end

  def user_store?
    current_user.user_stores.exists?(id)
  end

  def name
    store.class.name
  end

  def street1_with_street2
    "#{street1} #{street2}".strip
  end

  def to_partial_path
    "shared/#{name.underscore}"
  end

  private

  attr_reader :store, :current_user
end
