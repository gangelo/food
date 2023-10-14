# frozen_string_literal: true

# The user shopping list item model for this application.
class UserShoppingListItem < ApplicationRecord
  belongs_ot :user
  belongs_to :user_shopping_list
end
