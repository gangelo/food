# frozen_string_literal: true

# The presenter concern for this application.
module PresenterConcern
  extend ActiveSupport::Concern

  included do
    class << self
      def presenter_for(resource:, user:, view_context:, options: nil)
        options ||= {}
        "#{resource.class.name}Presenter".constantize.new(resource: resource, user: user, view_context: view_context, options: options)
      end
    end
  end

  def presenter(user:, view_context:, options: nil)
    self.class.presenter_for(resource: self, user: user, view_context: view_context, options: options)
  end
end
