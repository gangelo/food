# frozen_string_literal: true

# The state model for this application.
class State < ApplicationRecord
  before_save :before_save_edits

  validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { maximum: 14 }
  validates :postal_abbreviation, uniqueness: { case_sensitive: false }, length: { is: 2 }

  def before_save_edits
    self.name = name.titleize
    self.postal_abbreviation = postal_abbreviation.upcase
  end
end
