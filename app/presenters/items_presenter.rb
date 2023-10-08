# frozen_string_literal: true

# The items presenter to display a collection of
# ItemPresenter objects.
class ItemsPresenter < Presenter
  def presenters
    @presenters ||= map do |item|
      item.presenter(user: user, view_context: view_context, options: options)
    end.sort_by(&:item_name)
  end
end
