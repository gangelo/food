# frozen_string_literal: true

# This is the user shopping list model.
class UserShoppingList < ApplicationRecord
  include PagableConcern

  belongs_to :user
  belongs_to :shopping_list

  has_many :user_shopping_list_items, dependent: :destroy
  has_many :items, through: :user_shopping_list_items, source: :user_shopping_list

  accepts_nested_attributes_for :shopping_list
end
