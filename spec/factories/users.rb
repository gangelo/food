# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    username { "#{first_name[0]}#{last_name.gsub(/[^a-zA-Z]+/, '')}".downcase }
    email { FFaker::Internet.email.sub(/^[^@]+/, "#{first_name}.#{last_name}".downcase) }
    password { "#{FFaker::Internet.password}Xyz#04" }

    transient do
      stores_count { 2 }
    end

    trait :with_stores do
      after(:create) do |user, evaluator|
        evaluator.stores_count.times do
          store = FactoryBot.create(:store)
          FactoryBot.create(:user_store, user: user, store: store)
        end
      end
    end
  end
end
