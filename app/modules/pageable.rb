# frozen_string_literal: true

# Provides methods for pagination.
module Pageable
  module_function

  def page_for(ar_object, order_by:, page:, items_per_page:)
    ar_object.order(order_by).offset(pager_offset_for(page: page, items_per_page: items_per_page)).limit(items_per_page)
  end

  def pager_params_for(ar_object, page:, pages_between:, items_per_page:, pager_path:)
    total_pages = (ar_object.count.to_f / items_per_page).ceil

    return blank_pager_params if total_pages.zero?

    # Ensure the page and pages_between are within valid range
    page = page.clamp(1, total_pages)
    pages_between = pages_between.clamp(1, total_pages)

    # Calculate half of the pages_between
    half_way = (pages_between / 2.0).ceil

    # Adjust the starting_page to ensure `pages_between` pages are always displayed
    # and current page is centered when possible
    starting_page = if page + half_way > total_pages
                      [total_pages - pages_between + 1, 1].max
                    else
                      [page - half_way + 1, 1].max
                    end

    pages_between_range = (starting_page..[starting_page + pages_between - 1, total_pages].min).to_a

    # Next page...
    next_page = page + 1
    next_page = 0 if next_page > total_pages || next_page == page

    # Previous page...
    prev_page = page - 1
    prev_page = 0 if prev_page < 1 || prev_page == page

    # Previous page jump...
    prev_page_jump = [page - pages_between, 1].max
    prev_page_jump = 0 if pages_between_range.include?(1)

    # Next page jump...
    next_page_jump = [page + pages_between, total_pages].min
    next_page_jump = 0 if pages_between_range.include?(total_pages)

    page_offset = (page - 1) * items_per_page

    {
      total_pages: total_pages,
      current_page: page,
      page_offset: page_offset,
      prev_page: prev_page,
      prev_page_jump: prev_page_jump,
      pages_between_range: pages_between_range,
      next_page_jump: next_page_jump,
      next_page: next_page,
      pager_path: pager_path
    }
  end

  def pager_offset_for(page:, items_per_page:)
    return 0 unless page.positive?

    (page - 1) * items_per_page
  end

  def blank_pager_params
    {
      total_pages: 0,
      current_page: 0,
      page_offset: 0,
      prev_page: 0,
      prev_page_jump: 0,
      pages_between_range: [],
      next_page_jump: 0,
      next_page: 0,
      pager_path: ''
    }
  end
end
