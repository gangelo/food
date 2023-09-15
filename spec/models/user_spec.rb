# frozen_string_literal: true

RSpec.describe User do
  subject(:user) { build(:user) }

  describe 'validations' do
    describe '#first_name' do
      it 'validates the length' do
        expect(user).to validate_length_of(:first_name).is_at_least(1).is_at_most(64)
      end
    end

    describe '#last_name' do
      it 'validates the length' do
        expect(user).to validate_length_of(:last_name).is_at_least(1).is_at_most(64)
      end
    end

    describe '#email' do
      it 'validates the length' do
        expect(user).to validate_length_of(:email).is_at_least(3).is_at_most(320)
      end
    end

    describe '#username' do
      it 'validates the length' do
        expect(user).to validate_length_of(:username).is_at_least(4).is_at_most(64)
      end

      it 'validates the uniqueness' do
        expect(user).to validate_uniqueness_of(:username)
      end
    end

    describe '#password' do
      it 'validates the length' do
        expect(user).to validate_length_of(:password).is_at_least(8).is_at_most(128)
      end
    end
  end
end
