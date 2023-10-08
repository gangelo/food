# frozen_string_literal: true

# The presenter concern for this application.
module ArchivableConcern
  extend ActiveSupport::Concern

  included do
    scope :archived, -> { where(archived: true) }
    scope :unarchived, -> { where(archived: false) }
  end

  def archive!
    self.archived = true unless archived?
    save! if archived_changed?
  end

  def unarchive!
    self.archived = false if archived?
    save! if archived_changed?
  end

  def archived?
    archived
  end

  def unarchived?
    !archived?
  end
end
