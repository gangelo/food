# frozen_string_literal: true

# This is the user shopping list model.
class UserShoppingList < ApplicationRecord
  belongs_to :user
  belongs_to :shopping_list
end
