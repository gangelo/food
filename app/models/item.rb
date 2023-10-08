# frozen_string_literal: true

# The (store) Item model for this application.
class Item < ApplicationRecord
  include ArchivableConcern

  validates :item_name, uniqueness: { case_sensitive: false }
end
