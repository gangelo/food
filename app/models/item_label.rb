# frozen_string_literal: true

# The Label model for this application.
class ItemLabel < ApplicationRecord
  belongs_to :item
  belongs_to :label

  validates :item, presence: true
  validates :label, presence: true
end
