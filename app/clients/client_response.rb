# frozen_string_literal: true

# A module for generically formatting a response from
# a client API.
module ClientResponse
  CLIENT_API_ERROR_MESSAGE = "Oops! We're unable to communicate across the wire. Is your internet up?"

  module_function

  def format_response(success:, status_code:, message:, data: nil)
    data ||= {}

    yield data if block_given? && success

    {
      # Whether the request was successful or not.
      success: success,
      # The HTTP response code.
      status_code: status_code,
      # Any applicable message returned from the API
      # or manually set.
      message: message,
      # The data (if any) returned from the API.
      data: data
    }
  end

  def with_client_error_handling
    yield
  rescue HTTParty::Error => e
    Rails.logger.error("Possible 'Internal Server Error' error (no other information available): #{e.message}")
    format_response(success: false, status_code: 500, message: CLIENT_API_ERROR_MESSAGE)
  rescue SocketError => e
    Rails.logger.error("Possible 'Service Unavailable' error (no other information is available): #{e.message}")
    format_response(success: false, status_code: 503, message: CLIENT_API_ERROR_MESSAGE)
  rescue Timeout::Error => e
    Rails.logger.error("Possible 'Gateway Timeout' error (no other information is available): #{e.message}")
    format_response(success: false, status_code: 504, message: CLIENT_API_ERROR_MESSAGE)
  end
end
