# frozen_string_literal: true

json.key_format! camelize: :lower
json.deep_format_keys!

json.extract! @response, :success, :status_code, :message
json.merge! @response[:data]
