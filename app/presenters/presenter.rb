# frozen_string_literal: true

# The base presenter for all other presenters.
class Presenter < SimpleDelegator
  attr_reader :options, :user, :view_context

  alias vc view_context

  def initialize(resource:, user:, view_context:, options: nil)
    super(resource)

    @user = user
    @view_context = view_context
    @options = options || {}
  end
end
