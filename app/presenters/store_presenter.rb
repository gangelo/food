# frozen_string_literal: true

# The store presenter for this application.
class StorePresenter < SimpleDelegator
  def initialize(store, current_user)
    super(store)

    @current_user = current_user
  end

  # Returns true if the current user has an association with
  # the store that this presenter represents.
  def user_store?
    current_user.user_stores.exists?(store_id: id)
  end

  def address_with_address2
    "#{address} #{address2}".strip
  end

  # def name
  #   @name ||= __getobj__.class.name
  # end

  # def to_partial_path
  #   'shared/store'
  # end

  private

  attr_reader :current_user
end
