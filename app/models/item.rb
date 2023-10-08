# frozen_string_literal: true

# The (store) Item model for this application.
class Item < ApplicationRecord
  include ArchivableConcern
  include PagableConcern

  validates :item_name, uniqueness: { case_sensitive: false }
end
