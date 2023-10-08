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
    { postal_abbreviation: 'AL', state_name: 'Alabama' },
    { postal_abbreviation: 'AK', state_name: 'Alaska' },
    { postal_abbreviation: 'AZ', state_name: 'Arizona' },
    { postal_abbreviation: 'AR', state_name: 'Arkansas' },
    { postal_abbreviation: 'CA', state_name: 'California' },
    { postal_abbreviation: 'CO', state_name: 'Colorado' },
    { postal_abbreviation: 'CT', state_name: 'Connecticut' },
    { postal_abbreviation: 'DE', state_name: 'Delaware' },
    { postal_abbreviation: 'FL', state_name: 'Florida' },
    { postal_abbreviation: 'GA', state_name: 'Georgia' },
    { postal_abbreviation: 'HI', state_name: 'Hawaii' },
    { postal_abbreviation: 'ID', state_name: 'Idaho' },
    { postal_abbreviation: 'IL', state_name: 'Illinois' },
    { postal_abbreviation: 'IN', state_name: 'Indiana' },
    { postal_abbreviation: 'IA', state_name: 'Iowa' },
    { postal_abbreviation: 'KS', state_name: 'Kansas' },
    { postal_abbreviation: 'KY', state_name: 'Kentucky' },
    { postal_abbreviation: 'LA', state_name: 'Louisiana' },
    { postal_abbreviation: 'ME', state_name: 'Maine' },
    { postal_abbreviation: 'MD', state_name: 'Maryland' },
    { postal_abbreviation: 'MA', state_name: 'Massachusetts' },
    { postal_abbreviation: 'MI', state_name: 'Michigan' },
    { postal_abbreviation: 'MN', state_name: 'Minnesota' },
    { postal_abbreviation: 'MS', state_name: 'Mississippi' },
    { postal_abbreviation: 'MO', state_name: 'Missouri' },
    { postal_abbreviation: 'MT', state_name: 'Montana' },
    { postal_abbreviation: 'NE', state_name: 'Nebraska' },
    { postal_abbreviation: 'NV', state_name: 'Nevada' },
    { postal_abbreviation: 'NH', state_name: 'New Hampshire' },
    { postal_abbreviation: 'NJ', state_name: 'New Jersey' },
    { postal_abbreviation: 'NM', state_name: 'New Mexico' },
    { postal_abbreviation: 'NY', state_name: 'New York' },
    { postal_abbreviation: 'NC', state_name: 'North Carolina' },
    { postal_abbreviation: 'ND', state_name: 'North Dakota' },
    { postal_abbreviation: 'OH', state_name: 'Ohio' },
    { postal_abbreviation: 'OK', state_name: 'Oklahoma' },
    { postal_abbreviation: 'OR', state_name: 'Oregon' },
    { postal_abbreviation: 'PA', state_name: 'Pennsylvania' },
    { postal_abbreviation: 'RI', state_name: 'Rhode Island' },
    { postal_abbreviation: 'SC', state_name: 'South Carolina' },
    { postal_abbreviation: 'SD', state_name: 'South Dakota' },
    { postal_abbreviation: 'TN', state_name: 'Tennessee' },
    { postal_abbreviation: 'TX', state_name: 'Texas' },
    { postal_abbreviation: 'UT', state_name: 'Utah' },
    { postal_abbreviation: 'VT', state_name: 'Vermont' },
    { postal_abbreviation: 'VA', state_name: 'Virginia' },
    { postal_abbreviation: 'WA', state_name: 'Washington' },
    { postal_abbreviation: 'WV', state_name: 'West Virginia' },
    { postal_abbreviation: 'WI', state_name: 'Wisconsin' },
    { postal_abbreviation: 'WY', state_name: 'Wyoming' }
  ]

  us_states.each do |us_state|
    state = State.find_or_create_by(postal_abbreviation: us_state[:postal_abbreviation])

    # Update attributes if the record exists or create a new one if it doesn't
    state.update(us_state)
  end
end

def seed_stores
  Store.find_or_create_by(store_name: 'Acme',
                              address: '550 Myrtle Ave',
                              city: 'Boonton',
                              zip_code: '07005').tap do |store|
    store.update(state: State.find_by(postal_abbreviation: 'NJ'))
  end

  Store.find_or_create_by(store_name: 'Kings',
                              address: '115 Hawkins Pl',
                              city: 'Boonton',
                              zip_code: '07005').tap do |store|
    store.update(state: State.find_by(postal_abbreviation: 'NJ'))
  end

  Store.find_or_create_by(store_name: 'ShopRite',
                              address: '437 US-46',
                              city: 'Rockaway Township',
                              zip_code: '07801').tap do |store|
    store.update(state: State.find_by(postal_abbreviation: 'NJ'))
  end
end

def seed_items
  Item.find_or_create_by(item_name: 'Almonds')
  Item.find_or_create_by(item_name: 'Artichoke')
  Item.find_or_create_by(item_name: 'Arugula')
  Item.find_or_create_by(item_name: 'Bacon')
  Item.find_or_create_by(item_name: 'Banana')
  Item.find_or_create_by(item_name: 'Beef, chuck roast')
  Item.find_or_create_by(item_name: 'Beef, ground')
  Item.find_or_create_by(item_name: 'Beet, canned')
  Item.find_or_create_by(item_name: 'Beet')
  Item.find_or_create_by(item_name: 'Black pepper')
  Item.find_or_create_by(item_name: 'Black pepper, corns')
  Item.find_or_create_by(item_name: 'Broccoli')
  Item.find_or_create_by(item_name: 'Broccoli, raab')
  Item.find_or_create_by(item_name: 'Cabbage, napa')
  Item.find_or_create_by(item_name: 'Carrot')
  Item.find_or_create_by(item_name: 'Cauliflower')
  Item.find_or_create_by(item_name: 'Cayenne pepper')
  Item.find_or_create_by(item_name: 'Chicken, breast')
  Item.find_or_create_by(item_name: 'Chicken, legs')
  Item.find_or_create_by(item_name: 'Chicken, thighs')
  Item.find_or_create_by(item_name: 'Chicken, whole')
  Item.find_or_create_by(item_name: 'Chicken, wings')
  Item.find_or_create_by(item_name: 'Chili powder')
  Item.find_or_create_by(item_name: 'Chili powder, anchio')
  Item.find_or_create_by(item_name: 'Cilantro, dried')
  Item.find_or_create_by(item_name: 'Daikon')
  Item.find_or_create_by(item_name: 'Dill, dried')
  Item.find_or_create_by(item_name: 'Eggplant')
  Item.find_or_create_by(item_name: 'Fennel')
  Item.find_or_create_by(item_name: 'Fish, salmon')
  Item.find_or_create_by(item_name: 'Fish, tilapia')
  Item.find_or_create_by(item_name: 'Garlic powder')
  Item.find_or_create_by(item_name: 'Garlic')
  Item.find_or_create_by(item_name: 'Garlic, chopped')
  Item.find_or_create_by(item_name: 'Garlic, fresh')
  Item.find_or_create_by(item_name: 'Ginger, ground')
  Item.find_or_create_by(item_name: 'Horseradish')
  Item.find_or_create_by(item_name: 'Hot dogs')
  Item.find_or_create_by(item_name: 'Iceberg Lettuce')
  Item.find_or_create_by(item_name: 'Jicama')
  Item.find_or_create_by(item_name: 'Kale')
  Item.find_or_create_by(item_name: 'Lamb, chops')
  Item.find_or_create_by(item_name: 'Lamb, leg')
  Item.find_or_create_by(item_name: 'Leek')
  Item.find_or_create_by(item_name: 'Macadamia nuts')
  Item.find_or_create_by(item_name: 'Mushroom')
  Item.find_or_create_by(item_name: 'Onion powder')
  Item.find_or_create_by(item_name: 'Onion')
  Item.find_or_create_by(item_name: 'Onion, purple')
  Item.find_or_create_by(item_name: 'Onion, vadalia')
  Item.find_or_create_by(item_name: 'Onion, white')
  Item.find_or_create_by(item_name: 'Onion, yellow')
  Item.find_or_create_by(item_name: 'Orgegano')
  Item.find_or_create_by(item_name: 'Palenta')
  Item.find_or_create_by(item_name: 'Parsley, dried')
  Item.find_or_create_by(item_name: 'Pecans')
  Item.find_or_create_by(item_name: 'Pepper')
  Item.find_or_create_by(item_name: 'Pistachios')
  Item.find_or_create_by(item_name: 'Pork, belly')
  Item.find_or_create_by(item_name: 'Pork, chops')
  Item.find_or_create_by(item_name: 'Pork, loin')
  Item.find_or_create_by(item_name: 'Pork, ribs')
  Item.find_or_create_by(item_name: 'Quinoa') # Technically a seed, but often used as a vegetable
  Item.find_or_create_by(item_name: 'Radish')
  Item.find_or_create_by(item_name: 'Red pepper, crushed')
  Item.find_or_create_by(item_name: 'Romaine lettuce')
  Item.find_or_create_by(item_name: 'Salt')
  Item.find_or_create_by(item_name: 'Sausage, Italian hot')
  Item.find_or_create_by(item_name: 'Sausage, Italian mild')
  Item.find_or_create_by(item_name: 'Sausage, Italian sweet')
  Item.find_or_create_by(item_name: 'Sausage, breakfast')
  Item.find_or_create_by(item_name: 'Sesame seeds, black')
  Item.find_or_create_by(item_name: 'Sesame seeds, white')
  Item.find_or_create_by(item_name: 'Shrimp')
  Item.find_or_create_by(item_name: 'Spinach')
  Item.find_or_create_by(item_name: 'Steak, NY strip')
  Item.find_or_create_by(item_name: 'Steak, T-bone')
  Item.find_or_create_by(item_name: 'Steak, ribeye')
  Item.find_or_create_by(item_name: 'Steak, sirloin')
  Item.find_or_create_by(item_name: 'Turkey, ground')
  Item.find_or_create_by(item_name: 'Turkey, whole')
  Item.find_or_create_by(item_name: 'Turnip')
  Item.find_or_create_by(item_name: 'Ugli Fruit') # Fruit, but used for the sake of example
  Item.find_or_create_by(item_name: 'Vanilla bean')
  Item.find_or_create_by(item_name: 'Vanilla extract')
  Item.find_or_create_by(item_name: 'Walnuts')
  Item.find_or_create_by(item_name: 'Watercress')
  Item.find_or_create_by(item_name: 'Watermelon')
  Item.find_or_create_by(item_name: 'White pepper')
  Item.find_or_create_by(item_name: 'Yam')
  Item.find_or_create_by(item_name: 'Zucchini')
end

puts 'Seeding items...'
seed_items

puts 'Seeding US states...'
seed_us_states

puts 'Seeding stores...'
seed_stores

puts 'Done.'
