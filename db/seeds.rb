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
  items = {
    'Almond' => %w[nuts],
    'Artichoke' => %w[vegetables],
    'Arugula' => %w[vegetables greens],
    'Bacon' => %w[pork meat],
    'Banana' => %w[fruits],
    'Beef, chuck roast' => %w[beef meat],
    'Beef, ground' => %w[beef meat],
    'Beet, canned' => %w[vegetables canned],
    'Beet' => %w[vegetables],
    'Black pepper' => %w[spices],
    'Black pepper, corns' => %w[spices],
    'Broccoli' => %w[vegetables],
    'Broccoli, raab' => %w[vegetables greens],
    'Cabbage, napa' => %w[vegetables],
    'Carrot' => %w[vegetables],
    'Cauliflower' => %w[vegetables],
    'Cayenne pepper' => %w[spices],
    'Chicken, breast' => %w[chicken poultry meat],
    'Chicken, legs' => %w[chicken poultry meat],
    'Chicken, thighs' => %w[chicken poultry meat],
    'Chicken, whole' => %w[chicken poultry meat],
    'Chicken, wings' => %w[chicken poultry meat],
    'Chili powder' => %w[spices],
    'Chili powder, ancho' => %w[spices],
    'Cilantro, dried' => %w[herbs spices],
    'Daikon' => %w[vegetables],
    'Dill, dried' => %w[herbs spices],
    'Eggplant' => %w[vegetables],
    'Fennel' => %w[vegetables herbs],
    'Fish, salmon' => %w[fish seafood],
    'Fish, tilapia' => %w[fish seafood],
    'Garlic powder' => %w[spices],
    'Garlic' => %w[vegetables spices],
    'Garlic, chopped' => %w[vegetables spices],
    'Garlic, fresh' => %w[vegetables spices],
    'Ginger, ground' => %w[spices],
    'Horseradish' => %w[spices condiments],
    'Hot dogs' => %w[pork prepared meat],
    'Iceberg lettuce' => %w[vegetables greens],
    'Jicama' => %w[vegetables],
    'Kale' => %w[vegetables greens],
    'Lamb, chops' => %w[lamb meat],
    'Lamb, leg' => %w[lamb meat],
    'Leek' => %w[vegetables],
    'Macadamia nuts' => %w[nuts],
    'Mushroom' => %w[vegetables],
    'Onion powder' => %w[spices],
    'Onion' => %w[vegetables],
    'Onion, purple' => %w[vegetables],
    'Onion, vadalia' => %w[vegetables],
    'Onion, white' => %w[vegetables],
    'Onion, yellow' => %w[vegetables],
    'Oregano' => %w[herbs spices],
    'Palenta' => %w[grains],
    'Parsley, dried' => %w[herbs spices],
    'Pecans' => %w[nuts],
    'Pepper' => %w[vegetables spices],
    'Pistachios' => %w[nuts],
    'Pork, belly' => %w[pork meat],
    'Pork, chops' => %w[pork meat],
    'Pork, loin' => %w[pork meat],
    'Pork, ribs' => %w[pork meat],
    'Pretzels' => %w[breads snacks],
    'Quinoa' => %w[grains],
    'Radish' => %w[vegetables],
    'Red pepper, crushed' => %w[spices],
    'Romaine lettuce' => %w[vegetables greens],
    'Salt' => %w[spices],
    'Sausage, Italian hot' => %w[pork prepared meat],
    'Sausage, Italian mild' => %w[pork prepared meat],
    'Sausage, Italian sweet' => %w[pork prepared meat],
    'Sausage, breakfast' => %w[pork prepared meat],
    'Sesame seeds, black' => %w[seeds],
    'Sesame seeds, white' => %w[seeds],
    'Shrimp' => %w[shellfish seafood],
    'Spinach' => %w[vegetables greens],
    'Steak, NY strip' => %w[beef meat],
    'Steak, T-bone' => %w[beef meat],
    'Steak, ribeye' => %w[beef meat],
    'Steak, sirloin' => %w[beef meat],
    'Turkey, ground' => %w[turkey poultry meat],
    'Turkey, breast' => %w[turkey poultry meat],
    'Walnuts' => %w[nuts],
    'Wasabi' => %w[spices condiments],
    'Yam' => %w[vegetables],
    'Yogurt, Almond' => %w[yogurt vegan],
    'Yogurt, Cashew' => %w[yogurt vegan],
    'Yogurt, Coconut' => %w[yogurt vegan],
    'Yogurt, Greek' => %w[dairy yogurt],
    'Yogurt, plain' => %w[dairy yogurt],
    'Yogurt, vanilla' => %w[dairy yogurt],
    'Zucchini' => %w[vegetables]
  }

  items.each_pair do |item_name, item_labels|
    new_item = Item.find_or_create_by(item_name: item_name)
    new_item.item_labels = []
    new_item.labels << Label.where(label_name: item_labels)
  end
end

def seed_labels
  food = %w[
    baking
    beans
    beef
    beverages
    breads
    canned
    cereals
    cheeses
    chicken
    condiments
    dairy
    deli
    desserts
    dried
    edibles
    eggs
    fish
    food
    frozen
    fruits
    grains
    herbs
    lamb
    legumes
    meat
    nuts
    oils
    organic
    pasta
    pork
    prepared
    produce
    sauces
    seafood
    seeds
    shellfish
    snacks
    soups
    spices
    sweets
    turkey
    vegetables
    wholefoods
    yogurt
  ]
  non_food = %w[
    cleaning
    hygiene
    soap
    toiletries
  ]
  labels = [*food, *non_food].sort

  labels.each do |label|
    Label.find_or_create_by(label_name: label)
  end
end

puts 'Seeding labels...'
seed_labels

puts 'Seeding items...'
seed_items

puts 'Seeding US states...'
seed_us_states

puts 'Seeding stores...'
seed_stores

puts 'Done.'
