# frozen_string_literal: true

# The presenter concern for this application.
module PresenterConcern
  extend ActiveSupport::Concern

  included do
    class << self
      def presenter_for(object, current_user)
        "#{object.class.name}Presenter".constantize.new(object, current_user)
      end
    end
  end

  def presenter(current_user)
    self.class.presenter_for(self, current_user)
  end
end
