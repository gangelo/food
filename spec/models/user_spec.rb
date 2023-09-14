# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { build(:user) }

  describe 'validations' do
    describe '#first_name' do
      it 'validates the length of first_name' do
        expect(user).to validate_length_of(:first_name).is_at_least(1).is_at_most(64)
      end
    end
  end
end
