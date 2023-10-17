# frozen_string_literal: true

# The (store) Item model for this application.
class Item < ApplicationRecord
  include ArchivableConcern
  include PagableConcern

  has_many :user_shopping_list_items, dependent: :destroy

  validates :item_name, uniqueness: { case_sensitive: false }
end
