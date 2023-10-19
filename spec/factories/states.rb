# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    state_name { nil }
    postal_abbreviation { nil }

    after(:build) do |instance, _evaluator|
      return unless instance.state_name.nil? || instance.postal_abbreviation.nil?

      state = nil
      us_states.each do |us_state|
        state = us_state
        break unless State.find_by(state_name: us_state[:state_name])
      end

      raise 'All states have been instantiated' if state.nil?

      instance.state_name = state[:state_name] if instance.state_name.nil?
      instance.postal_abbreviation = state[:postal_abbreviation] if instance.postal_abbreviation.nil?
    end
  end
end
