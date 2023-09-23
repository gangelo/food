# frozen_string_literal: true

# This is the application record file for the application.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include PresenterConcern
end
