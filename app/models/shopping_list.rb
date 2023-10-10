# frozen_string_literal: true

# The shopping list model.
class ShoppingList < ApplicationRecord
  has_many :user_shopping_lists
  has_many :users, through: :user_shopping_lists

  validates :shopping_list_name, uniqueness: { scope: :week_of, case_sensitive: false }
end
