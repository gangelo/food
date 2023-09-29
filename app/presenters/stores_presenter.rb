# frozen_string_literal: true

# The stores presenter to display a collection of
# StorePresenter objects.
class StoresPresenter < Presenter
  def presenters
    @presenters ||= map do |store|
      store.presenter(user: user, view_context: view_context, options: options)
    end.sort_by(&:store_name)
  end

  def user_stores?
    user.user_stores.any?
  end
end
