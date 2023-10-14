# frozen_string_literal: true

# This is the user shopping list model.
class UserShoppingList < ApplicationRecord
  include PagableConcern

  belongs_to :user
  belongs_to :shopping_list

  # has_many :items, dependent: :destroy
  # has_many :user_shopping_list_items, through: :user_shopping_list_items, source: :item

  accepts_nested_attributes_for :shopping_list
end
