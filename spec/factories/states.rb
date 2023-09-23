# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    state_name { FFaker::AddressUS.state }
    postal_abbreviation { FFaker::AddressUS.state_abbr }
  end
end
