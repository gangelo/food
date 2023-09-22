# frozen_string_literal: true

module ZipCodeApi
  # The client for the Zip Code API.
  class ZipCodeClient
    include HTTParty
    include ClientResponse

    class << self
      def get_zip_code_data(zip_code, base_uri: nil)
        new(base_uri: base_uri).get_zip_code_data(zip_code)
      end
    end

    def initialize(base_uri: nil)
      self.class.base_uri base_uri || ENV.fetch('ZIP_CODE_API_BASE_URL')
    end

    def get_zip_code_data(zip_code)
      with_client_error_handling do
        endpoint = File.join(self.class.base_uri, country_code, zip_code)
        response = self.class.get(endpoint)
        format_response(success: response.success?, status_code: response.code,
                        message: response.message) do |data|
          merge_response_data(data, response)
        end
      end
    end

    private

    def country_code
      # Hard coded to US for now.
      'US'
    end

    def merge_response_data(data, response) # rubocop:disable Metrics/MethodLength
      raise ArgumentError, 'response was not successful' unless response.success?

      first_place = response['places'].first

      data.merge!(
        {
          city: first_place['place name'],
          state: first_place['state'],
          zip_code: response['post code'],
          country: response['country'],
          latitude: first_place['latitude'],
          longitude: first_place['longitude'],
          country_abbreviation: response['country abbreviation'],
          state_abbreviation: first_place['state abbreviation']
        }
      )
    end
  end
end
