# frozen_string_literal: true

# The (store) Item model for this application.
class Item < ApplicationRecord
  include ArchivableConcern
  include PagableConcern

  belongs_to :user_shopping_list_items, required: false

  validates :item_name, uniqueness: { case_sensitive: false }
end
