# frozen_string_literal: true

# The stores presenter to display a collection of
# StorePresenter objects.
class StoresPresenter < SimpleDelegator
  attr_reader :name, :stores

  def initialize(stores, current_user)
    @name = stores.model.name.pluralize
    @stores = stores.map { |store| StorePresenter.new(store, current_user) }

    super(@stores)

    @current_user = current_user
  end

  def user_stores?
    current_user.stores.count.positive?
  end

  def to_partial_path
    "stores/#{name.underscore}"
  end

  private

  attr_reader :current_user
end
