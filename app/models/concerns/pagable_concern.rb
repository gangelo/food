# frozen_string_literal: true

# The pagable concern for model pagination.
module PagableConcern
  extend ActiveSupport::Concern

  included do
    scope :for_page, lambda { |order_by, page, items_per_page|
      page ||= 0
      order(order_by).offset(offset_for(page, items_per_page)).limit(items_per_page)
    }
  end

  # Class methods for the pagable concern.
  module ClassMethods
    def offset_for(page, items_per_page)
      return 0 unless page.positive?

      (page - 1) * items_per_page
    end

    def pager_params_for(page:, pages_between:, items_per_page:)
      total_pages = (count.to_f / items_per_page).ceil

      # Ensure the page and pages_between are within valid range
      page = [[page, 1].max, total_pages].min
      pages_between = [pages_between, total_pages].min

      # Calculate half of the pages_between
      half_way = (pages_between / 2.0).ceil

      # Adjust the starting_page to ensure `pages_between` pages are always displayed
      # and current page is centered when possible
      starting_page = if page + half_way > total_pages
                        # If exceeding total pages, rewind starting_page
                        [total_pages - pages_between + 1, 1].max
                      else
                        # Attempt to center the current page
                        [page - half_way + 1, 1].max
                      end

      pages_between_range = (starting_page..[starting_page + pages_between - 1, total_pages].min).to_a

      next_page = pages_between_range.last + 1 <= total_pages ? pages_between_range.last + 1 : 0
      prev_page = page - 1 >= 1 ? page - 1 : 0

      page_offset = (page - 1) * items_per_page

      {
        current_page: page,
        page_offset: page_offset,
        prev_page: prev_page,
        pages_between_range: pages_between_range,
        next_page: next_page
      }
    end
  end
end
