# frozen_string_literal: true

# The pagable concern for model pagination.
module PagableConcern
  extend ActiveSupport::Concern

  included do
    scope :page_for, lambda { |page:, order_by:, items_per_page:|
      Pageable.page_for(self,
                        page: page,
                        order_by: order_by,
                        items_per_page: items_per_page)
    }
  end

  # Class methods for the pagable concern.
  module ClassMethods
    def pager_params_for(page:, pages_between:, items_per_page:, pager_path:)
      Pageable.pager_params_for(self,
                                page: page,
                                pages_between: pages_between,
                                items_per_page: items_per_page,
                                pager_path: pager_path)
    end
  end
end
