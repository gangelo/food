# frozen_string_literal: true

# The Label model for this application.
class Label < ApplicationRecord
  has_many :item_labels, dependent: :destroy
  has_many :items, through: :item_labels

  validates :label_name, presence: true, uniqueness: { case_sensitive: false }
end
