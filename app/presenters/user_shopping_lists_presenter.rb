# frozen_string_literal: true

# The user_stores presenter to display a collection of
# UserShoppingList objects.
class UserShoppingListsPresenter < Presenter
  def presenters
    @presenters ||= begin
      sorted_user_shopping_lists = map.sort_by do |user_shopping_lists|
        user_shopping_lists.shopping_list.shopping_list_name
      end
      sorted_user_shopping_lists.map do |user_shopping_list|
        user_shopping_list.presenter(user: user, view_context: view_context, options: options)
      end
    end
  end
end
