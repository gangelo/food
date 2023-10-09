# frozen_string_literal: true

# The pager presenter for pagination.
class PagerPresenter
  NO_ACTION_CSS_CLASS = 'no-action'

  attr_reader :options, :user, :view_context

  alias vc view_context

  def initialize(pager_params:, user:, view_context:, options: nil)
    @pager_params = pager_params
    @user = user
    @view_context = view_context
    @options = options || {}
  end

  # The href for the <a> tags used for paginination.
  def pager_href_for(page:)
    return nil if current_page?(page)

    "#{pager_params[:pager_path]}/#{page}"
  end

  def page_css(page)
    "active #{NO_ACTION_CSS_CLASS}" if current_page?(page)
  end

  def no_action_css
    NO_ACTION_CSS_CLASS
  end

  # Use this value to determine the row number for the currently
  # presented page, for example:
  # <view object row number> = page_offset + (<view object>_counter + 1)
  def page_offset
    pager_params[:page_offset]
  end

  def previous_page_css
    'disabled' unless prev_page?
  end

  def next_page_css
    'disabled' unless next_page?
  end

  def prev_page
    pager_params[:prev_page]
  end

  def next_page
    pager_params[:next_page]
  end

  def pages_between_range
    pager_params[:pages_between_range]
  end

  def prev_page_jump
    pager_params[:prev_page_jump]
  end

  def prev_page_jump_css
    'disabled' unless prev_page_jump?
  end

  def next_page_jump
    pager_params[:next_page_jump]
  end

  def next_page_jump_css
    'disabled' unless next_page_jump?
  end

  private

  attr_reader :pager_params

  def current_page
    pager_params[:current_page]
  end

  def current_page?(page)
    page == current_page
  end

  def next_page?
    next_page.positive?
  end

  def prev_page?
    prev_page.positive?
  end

  def next_page_jump?
    next_page_jump.positive?
  end

  def prev_page_jump?
    prev_page_jump.positive?
  end

  def pages_between_range?
    pages_between_range.any?
  end
end
