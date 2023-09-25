# frozen_string_literal: true

# The stores presenter to display a collection of
# StorePresenter objects.
class StoresPresenter < SimpleDelegator
  def initialize(stores, current_user)
    super(stores)

    @current_user = current_user
  end

  def presenters
    @presenters ||= map { |store| store.presenter(current_user) }.sort_by(&:store_name)
  end

  def user_stores?
    current_user.user_stores.any?
  end

  # def name
  #   @name ||= model.name.pluralize
  # end

  # def to_partial_path
  #   'shared/stores'
  # end

  private

  attr_reader :current_user
end
