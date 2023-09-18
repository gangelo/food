# frozen_string_literal: true

RSpec.describe User do
  subject(:user) { build(:user) }

  RSpec.shared_examples 'the password complexity is validated' do
    let(:expected_error) do
      /Password must include at least one upper and lowercase letter, one number, and one special character/
    end

    it 'validates the password complexity' do
      expect(user.errors.full_messages).to include(expected_error)
    end
  end

  describe 'validations' do
    describe '#first_name' do
      it 'validates presence' do
        expect(user).to validate_presence_of(:first_name)
      end

      it 'validates the length' do
        expect(user).to validate_length_of(:first_name).is_at_most(64)
      end
    end

    describe '#last_name' do
      it 'validates presence' do
        expect(user).to validate_presence_of(:last_name)
      end

      it 'validates the length' do
        expect(user).to validate_length_of(:last_name).is_at_most(64)
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

    describe 'password complexity' do
      context 'when creating the user' do
        subject(:user) { build(:user, password: 'not complex') }

        before do
          user.save
        end

        it_behaves_like 'the password complexity is validated'
      end

      context 'when updating an existing user' do
        subject(:user) { create(:user) }

        before do
          user.password = 'not complex'
          user.save
        end

        it_behaves_like 'the password complexity is validated'
      end
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
