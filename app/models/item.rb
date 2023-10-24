# frozen_string_literal: true

# The (store) Item model for this application.
class Item < ApplicationRecord
  include ArchivableConcern
  include PagableConcern

  has_many :user_shopping_list_items, dependent: :destroy

  has_many :item_labels, dependent: :destroy
  has_many :labels, through: :item_labels

  validates :item_name, presence: true, uniqueness: { case_sensitive: false }
end
