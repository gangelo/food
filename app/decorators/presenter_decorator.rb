# frozen_string_literal: true

# Decorates the resource so that a presenter can be
# obtained in the views.
class PresenterDecorator < SimpleDelegator
  def initialize(resource:, user:, view_context:, options: nil)
    super(resource)

    @user = user
    @view_context = view_context
    @options = options || {}
  end

  def presenter(options: nil)
    options = self.options.merge(options || {})
    __getobj__.presenter(user: user, view_context: view_context, options: options)
  end

  def presenters(options: nil)
    return [] unless respond_to? :map

    map { |resource| presenter_for(resource, options: options) }
  end

  def presenter_for(resource, options: nil)
    options = self.options.merge(options || {})
    resource.presenter(user: user, view_context: view_context, options: options)
  end

  private

  attr_reader :user, :view_context, :options
end
