# frozen_string_literal: true

module Api
  # The controller that handles client API integration for this application.
  class ZipCodesController < ApplicationController
    # define a zip_code_data action that returns
    # a jbuilder view of the zip code data
    def zip_code_data
      zip_code = params[:zip_code]
      @response = ZipCodeApi::ZipCodeClient.get_zip_code_data(zip_code)

      respond_to(&:json)
    end
  end
end
