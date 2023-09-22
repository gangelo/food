json.extract! @response, :success, :status_code, :message

json.data do
  json.city @response[:data][:city]
  json.state @response[:data][:state]
  json.zip_code @response[:data][:zip_code]
  json.country @response[:data][:country]
  json.latitude @response[:data][:latitude]
  json.longitude @response[:data][:longitude]
  json.country_abbreviation @response[:data][:country_abbreviation]
  json.state_abbreviation @response[:data][:state_abbreviation]
end
