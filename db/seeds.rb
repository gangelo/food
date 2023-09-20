# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed_us_states
  us_states = [
    { name: 'Alabama', postal_abbreviation: 'AL' },
    { name: 'Alaska', postal_abbreviation: 'AK' },
    { name: 'Arizona', postal_abbreviation: 'AZ' },
    { name: 'Arkansas', postal_abbreviation: 'AR' },
    { name: 'California', postal_abbreviation: 'CA' },
    { name: 'Colorado', postal_abbreviation: 'CO' },
    { name: 'Connecticut', postal_abbreviation: 'CT' },
    { name: 'Delaware', postal_abbreviation: 'DE' },
    { name: 'Florida', postal_abbreviation: 'FL' },
    { name: 'Georgia', postal_abbreviation: 'GA' },
    { name: 'Hawaii', postal_abbreviation: 'HI' },
    { name: 'Idaho', postal_abbreviation: 'ID' },
    { name: 'Illinois', postal_abbreviation: 'IL' },
    { name: 'Indiana', postal_abbreviation: 'IN' },
    { name: 'Iowa', postal_abbreviation: 'IA' },
    { name: 'Kansas', postal_abbreviation: 'KS' },
    { name: 'Kentucky', postal_abbreviation: 'KY' },
    { name: 'Louisiana', postal_abbreviation: 'LA' },
    { name: 'Maine', postal_abbreviation: 'ME' },
    { name: 'Maryland', postal_abbreviation: 'MD' },
    { name: 'Massachusetts', postal_abbreviation: 'MA' },
    { name: 'Michigan', postal_abbreviation: 'MI' },
    { name: 'Minnesota', postal_abbreviation: 'MN' },
    { name: 'Mississippi', postal_abbreviation: 'MS' },
    { name: 'Missouri', postal_abbreviation: 'MO' },
    { name: 'Montana', postal_abbreviation: 'MT' },
    { name: 'Nebraska', postal_abbreviation: 'NE' },
    { name: 'Nevada', postal_abbreviation: 'NV' },
    { name: 'New Hampshire', postal_abbreviation: 'NH' },
    { name: 'New Jersey', postal_abbreviation: 'NJ' },
    { name: 'New Mexico', postal_abbreviation: 'NM' },
    { name: 'New York', postal_abbreviation: 'NY' },
    { name: 'North Carolina', postal_abbreviation: 'NC' },
    { name: 'North Dakota', postal_abbreviation: 'ND' },
    { name: 'Ohio', postal_abbreviation: 'OH' },
    { name: 'Oklahoma', postal_abbreviation: 'OK' },
    { name: 'Oregon', postal_abbreviation: 'OR' },
    { name: 'Pennsylvania', postal_abbreviation: 'PA' },
    { name: 'Rhode Island', postal_abbreviation: 'RI' },
    { name: 'South Carolina', postal_abbreviation: 'SC' },
    { name: 'South Dakota', postal_abbreviation: 'SD' },
    { name: 'Tennessee', postal_abbreviation: 'TN' },
    { name: 'Texas', postal_abbreviation: 'TX' },
    { name: 'Utah', postal_abbreviation: 'UT' },
    { name: 'Vermont', postal_abbreviation: 'VT' },
    { name: 'Virginia', postal_abbreviation: 'VA' },
    { name: 'Washington', postal_abbreviation: 'WA' },
    { name: 'West Virginia', postal_abbreviation: 'WV' },
    { name: 'Wisconsin', postal_abbreviation: 'WI' },
    { name: 'Wyoming', postal_abbreviation: 'WY' }
  ]

  us_states.each do |us_state|
    state = State.find_or_initialize_by(postal_abbreviation: us_state[:postal_abbreviation])

    # Update attributes if the record exists or create a new one if it doesn't
    state.update(us_state)
  end
end

def seed_stores
  store = Store.find_or_initialize_by(name: 'Kings', street1: '115 Hawkins Pl', city: 'Boonton', zip_code: '07005')
  store.update(state: State.find_by(postal_abbreviation: 'NJ'))

  store = Store.find_or_initialize_by(name: 'ACME', street1: '550 Myrtle Ave', city: 'Boonton', zip_code: '07005')
  store.update(state: State.find_by(postal_abbreviation: 'NJ'))
end

puts 'Seeding US states...'
seed_us_states

puts 'Seeding stores...'
seed_stores

puts 'Done.'
