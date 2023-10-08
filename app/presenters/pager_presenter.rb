# frozen_string_literal: true

# The pager presenter for pagination.
class PagerPresenter
  attr_reader :options, :user, :view_context

  alias vc view_context

  def initialize(pager_params:, user:, view_context:, options: nil)
    @pager_params = pager_params
    @user = user
    @view_context = view_context
    @options = options || {}
  end

  def current_page
    pager_params[:current_page]
  end

  def current_page?(page)
    page == current_page
  end

  def page_css(page)
    'disabled' if current_page?(page)
  end

  def page_offset
    pager_params[:page_offset]
  end

  def previous_page_css
    'disabled' unless prev_page?
  end

  def next_page_css
    'disabled' unless next_page?
  end

  def prev_page?
    prev_page.positive?
  end

  def prev_page
    pager_params[:prev_page]
  end

  def next_page?
    next_page.positive?
  end

  def next_page
    pager_params[:next_page]
  end

  def pages_between_range?
    pages_between_range.any?
  end

  def pages_between_range
    pager_params[:pages_between_range]
  end

  private

  attr_reader :pager_params
end
