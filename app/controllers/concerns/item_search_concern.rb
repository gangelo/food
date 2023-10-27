# frozen_string_literal: true

# This is a concern used to search for items
# in the database, and act as a generic #search
# action on the including controller.
module ItemSearchConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_search_params, only: %i[search]
    before_action :set_search_results, only: %i[search]
  end

  private

  def set_search_params
    @search_params = params[:query]
  end

  def set_search_results
    @search_results = Item.where('item_name ILIKE ?', "%#{@search_params}%").order(:item_name)
  end
end
