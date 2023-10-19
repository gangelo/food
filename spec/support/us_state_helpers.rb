# frozen_string_literal: true

module UsStateHelpers
  def random_us_state
    us_states[rand(0...us_states.length)]
  end

  def us_states # rubocop:disable Metrics/MethodLength
    @us_states ||= [
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
  end
end
