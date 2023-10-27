# frozen_string_literal: true

# The Label model for this application.
class Label < ApplicationRecord
  include ArchivableConcern
  include PagableConcern

  has_many :item_labels, dependent: :destroy
  has_many :items, through: :item_labels

  accepts_nested_attributes_for :item_labels

  validates :label_name, presence: true, uniqueness: { case_sensitive: false }

  attr_accessor :query

  def to_hash
    {
      id: id,
      label_name: label_name,
      items: sorted_items
    }
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end

  private

  # TODO: Put this in a mixin.
  def sorted_items
    items.order(item_name: :asc).map do |item|
      {
        id: item.id,
        item_name: item.item_name,
        archived: item.archived
      }
    end
  end
end
