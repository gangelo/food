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

    # def pager_params_for(page:, pages_between:, items_per_page:)
    #   total_pages = (count.to_f / items_per_page).ceil

    #   pages_between_range = (page + 1..[page + pages_between, total_pages].min).to_a
    #   next_page = pages_between_range.last + 1 <= total_pages ? pages_between_range.last + 1 : 0

    #   prev_page = page - 1
    #   prev_page = 0 if prev_page.negative?
    #   {
    #     page_offset: offset_for(page, items_per_page),
    #     prev_page: prev_page,
    #     pages_between_range: pages_between_range,
    #     next_page: next_page
    #   }
    # end

    def pager_params_for(page:, pages_between:, items_per_page:)
      total_pages = (count.to_f / items_per_page).ceil

      # Adjust the starting_page to ensure `pages_between` pages are always displayed
      starting_page = if page + pages_between > total_pages
                        # If exceeding total pages, rewind starting_page
                        [total_pages - pages_between + 1, 1].max
                      else
                        page + 1
                      end

      pages_between_range = (starting_page..[starting_page + pages_between - 1, total_pages].min).to_a

      next_page = pages_between_range.last + 1 <= total_pages ? pages_between_range.last + 1 : 0
      prev_page = page - 1
      prev_page = 0 if prev_page.negative?

      {
        page_offset: (page - 1) * items_per_page,
        prev_page: prev_page,
        pages_between_range: pages_between_range,
        next_page: next_page
      }
    end

  end
end
