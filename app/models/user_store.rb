# frozen_string_literal: true

# The user_store model for this application.
class UserStore < ApplicationRecord
  belongs_to :user
  belongs_to :store
end
