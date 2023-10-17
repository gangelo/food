# frozen_string_literal: true

# The user shopping list item model for this application.
class UserShoppingListItem < ApplicationRecord
  belongs_to :user_shopping_list
  belongs_to :item
end
