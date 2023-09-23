# frozen_string_literal: true

# The stores presenter to display a collection of
# StorePresenter objects.
class StoresPresenter < SimpleDelegator
  attr_reader :name

  def initialize(stores, current_user)
    @name = stores.model.name.pluralize

    super(stores.map { |store| StorePresenter.new(store, current_user) })

    @stores = stores
    @current_user = current_user
  end

  def user_stores?
    current_user.stores.count.positive?
  end

  # def name
  #   store.class.name
  # end

  def to_partial_path
    "shared/#{name.underscore}"
  end

  private

  attr_reader :stores, :current_user
end
