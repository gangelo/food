# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ state_name: "Star Wars" }, { state_name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed_us_states
  us_states = [
    { state_name: 'Alabama', postal_abbreviation: 'AL' },
    { state_name: 'Alaska', postal_abbreviation: 'AK' },
    { state_name: 'Arizona', postal_abbreviation: 'AZ' },
    { state_name: 'Arkansas', postal_abbreviation: 'AR' },
    { state_name: 'California', postal_abbreviation: 'CA' },
    { state_name: 'Colorado', postal_abbreviation: 'CO' },
    { state_name: 'Connecticut', postal_abbreviation: 'CT' },
    { state_name: 'Delaware', postal_abbreviation: 'DE' },
    { state_name: 'Florida', postal_abbreviation: 'FL' },
    { state_name: 'Georgia', postal_abbreviation: 'GA' },
    { state_name: 'Hawaii', postal_abbreviation: 'HI' },
    { state_name: 'Idaho', postal_abbreviation: 'ID' },
    { state_name: 'Illinois', postal_abbreviation: 'IL' },
    { state_name: 'Indiana', postal_abbreviation: 'IN' },
    { state_name: 'Iowa', postal_abbreviation: 'IA' },
    { state_name: 'Kansas', postal_abbreviation: 'KS' },
    { state_name: 'Kentucky', postal_abbreviation: 'KY' },
    { state_name: 'Louisiana', postal_abbreviation: 'LA' },
    { state_name: 'Maine', postal_abbreviation: 'ME' },
    { state_name: 'Maryland', postal_abbreviation: 'MD' },
    { state_name: 'Massachusetts', postal_abbreviation: 'MA' },
    { state_name: 'Michigan', postal_abbreviation: 'MI' },
    { state_name: 'Minnesota', postal_abbreviation: 'MN' },
    { state_name: 'Mississippi', postal_abbreviation: 'MS' },
    { state_name: 'Missouri', postal_abbreviation: 'MO' },
    { state_name: 'Montana', postal_abbreviation: 'MT' },
    { state_name: 'Nebraska', postal_abbreviation: 'NE' },
    { state_name: 'Nevada', postal_abbreviation: 'NV' },
    { state_name: 'New Hampshire', postal_abbreviation: 'NH' },
    { state_name: 'New Jersey', postal_abbreviation: 'NJ' },
    { state_name: 'New Mexico', postal_abbreviation: 'NM' },
    { state_name: 'New York', postal_abbreviation: 'NY' },
    { state_name: 'North Carolina', postal_abbreviation: 'NC' },
    { state_name: 'North Dakota', postal_abbreviation: 'ND' },
    { state_name: 'Ohio', postal_abbreviation: 'OH' },
    { state_name: 'Oklahoma', postal_abbreviation: 'OK' },
    { state_name: 'Oregon', postal_abbreviation: 'OR' },
    { state_name: 'Pennsylvania', postal_abbreviation: 'PA' },
    { state_name: 'Rhode Island', postal_abbreviation: 'RI' },
    { state_name: 'South Carolina', postal_abbreviation: 'SC' },
    { state_name: 'South Dakota', postal_abbreviation: 'SD' },
    { state_name: 'Tennessee', postal_abbreviation: 'TN' },
    { state_name: 'Texas', postal_abbreviation: 'TX' },
    { state_name: 'Utah', postal_abbreviation: 'UT' },
    { state_name: 'Vermont', postal_abbreviation: 'VT' },
    { state_name: 'Virginia', postal_abbreviation: 'VA' },
    { state_name: 'Washington', postal_abbreviation: 'WA' },
    { state_name: 'West Virginia', postal_abbreviation: 'WV' },
    { state_name: 'Wisconsin', postal_abbreviation: 'WI' },
    { state_name: 'Wyoming', postal_abbreviation: 'WY' }
  ]

  us_states.each do |us_state|
    state = State.find_or_initialize_by(postal_abbreviation: us_state[:postal_abbreviation])

    # Update attributes if the record exists or create a new one if it doesn't
    state.update(us_state)
  end
end

def seed_stores
  store = Store.find_or_initialize_by(store_name: 'Kings', address: '115 Hawkins Pl', city: 'Boonton', zip_code: '07005')
  store.update(state: State.find_by(postal_abbreviation: 'NJ'))

  store = Store.find_or_initialize_by(store_name: 'ACME', address: '550 Myrtle Ave', city: 'Boonton', zip_code: '07005')
  store.update(state: State.find_by(postal_abbreviation: 'NJ'))
end

puts 'Seeding US states...'
seed_us_states

puts 'Seeding stores...'
seed_stores

puts 'Done.'
