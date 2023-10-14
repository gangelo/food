# frozen_string_literal: true

# The user_stores presenter to display a collection of
# StorePresenter objects.
class UserStoresPresenter < Presenter
  def presenters
    @presenters ||= map do |user_store|
      UserStorePresenter.new(resource: user_store.store, view_context: view_context, user: user, options: options)
    end.sort_by(&:store_name)
  end

  def stores?
    count.positive?
  end
end
