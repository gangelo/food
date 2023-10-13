# frozen_string_literal: true

# The shopping lists presenter to display a collection of
# ShoppingListPresenter objects.
class ShoppingListsPresenter < Presenter
  def presenters
    @presenters ||= begin
      shopping_lists = map do |shopping_list|
        shopping_list.presenter(user: user, view_context: view_context, options: options)
      end
      shopping_lists.sort do |a, b|
        [b.week_of, a.shopping_list_name] <=> [a.week_of, b.shopping_list_name]
      end
    end
  end
end
