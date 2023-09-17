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

      it 'validates the uniqueness' do
        expect(user).to validate_uniqueness_of(:email).case_insensitive
      end

    end

    describe '#username' do
      it 'validates the length' do
        expect(user).to validate_length_of(:username).is_at_least(4).is_at_most(64)
      end

      it 'validates the uniqueness' do
        expect(user).to validate_uniqueness_of(:username).case_insensitive
      end
    end

    describe '#password' do
      it 'validates the length' do
        expect(user).to validate_length_of(:password).is_at_least(8).is_at_most(128)
      end
    end

    describe '#password_confirmation' do
      it 'validates the length' do
        expect(user).to validate_presence_of(:password_confirmation).on(:create)
      end
    end

    describe 'password complexity' do
      it 'validates the password complexity'
    end
  end

  describe 'callbacks' do
    describe 'before_save' do
      subject(:user) { build(:user, email: email) }

      let(:email) { 'UPCASE.EMAIL@SOMEWHERE.COM' }

      it 'downcases the email' do
        expect { user.save }.to change(user, :email).from(email).to(email.downcase)
      end
    end
  end
end
