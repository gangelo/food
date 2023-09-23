# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    store_name { FFaker::Company.name }
    address { FFaker::Address.street_address }
    address2 { FFaker::Address.secondary_address }
    city { FFaker::Address.city }
    state
    zip_code { FFaker::AddressUS.zip_code }
  end
end
