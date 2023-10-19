# frozen_string_literal: true

# This is the user shopping list model.
class UserShoppingList < ApplicationRecord
  include PagableConcern

  belongs_to :user
  belongs_to :shopping_list

  has_many :user_shopping_list_items, dependent: :destroy
  has_many :items, through: :user_shopping_list_items, source: :item

  accepts_nested_attributes_for :shopping_list

  validate :shopping_list_items_required

  def to_hash
    {
      id: id,
      shopping_list: {
        id: shopping_list.id,
        shopping_list_name: shopping_list.shopping_list_name
      },
      user_shopping_list_items: sorted_user_shopping_list_items
    }
  end

  private

  def sorted_user_shopping_list_items
    items.order(item_name: :asc).map do |item|
      {
        id: item.id,
        item_name: item.item_name,
        archived: item.archived
      }
    end
  end

  def shopping_list_items_required
    if items.empty?
      errors.add(:base, 'Shopping lists must have at least one item')
    end
  end
end
