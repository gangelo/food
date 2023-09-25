# frozen_string_literal: true

# The user_stores presenter to display a collection of
# StorePresenter objects.
class UserStoresPresenter < SimpleDelegator
  def initialize(user_stores, current_user)
    super(user_stores)

    @current_user = current_user
  end

  def presenters
    @presenters ||= map do |user_store|
      UserStorePresenter.new(user_store.store, current_user)
    end.sort_by(&:store_name)
  end

  def presenter_for(store_id)
    presenters.find { |presenter| presenter.id == store_id }
  end

  def stores?
    count.positive?
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
