# frozen_string_literal: true

# The user shopping_list presenter to display the shopping_list associated with
# a user's user_shopping_list association.
class UserShoppingListPresenter < Presenter
  def shopping_list_presenter
    shopping_list.presenter(user: user, view_context: view_context)
  end

  def items_json
    to_hash[:items].to_json
  end
end
