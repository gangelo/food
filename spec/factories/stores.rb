# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    store_name { FFaker::Company.name }
    street1 { FFaker::Address.street_address }
    street2 { FFaker::Address.secondary_address }
    city { FFaker::Address.city }
    state
    zip_code { FFaker::AddressUS.zip_code }
  end
end
