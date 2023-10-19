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

  describe 'associations' do
    it 'has many shopping lists through user shopping lists'
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

  describe 'class methods' do
    describe '.find_for_database_authentication' do
      subject(:user) { create(:user, username: username, email: email) }

      before do
        user
      end

      let(:username) { 'testuser' }
      let(:email) { 'test@example.com' }

      context "when searching by username using 'email_or_username: <username>'" do
        it 'returns the correct user when using :email_or_username' do
          found_user = described_class.find_for_database_authentication(email_or_username: username)
          expect(found_user).to eq(user)
        end
      end

      context "when searching by username using 'username: <username>'" do
        it 'returns the correct user' do
          found_user = described_class.find_for_database_authentication(username: username)
          expect(found_user).to eq(user)
        end
      end

      context "when searching case-insensitive by username using 'email_or_username: <username>'" do
        it 'returns the correct user' do
          found_user = described_class.find_for_database_authentication(email_or_username: username.upcase)
          expect(found_user).to eq(user)
        end
      end

      context "when searching case-insensitive by username using 'username: <username>'" do
        it 'returns the correct user when using :username' do
          found_user = described_class.find_for_database_authentication(username: username.upcase)
          expect(found_user).to eq(user)
        end
      end

      context "when searching by email using 'email_or_username: <email>'" do
        it 'returns the correct user' do
          found_user = described_class.find_for_database_authentication(email_or_username: email)
          expect(found_user).to eq(user)
        end
      end

      context "when searching by email using 'email: <email>'" do
        it 'returns the correct user' do
          found_user = described_class.find_for_database_authentication(email: email)
          expect(found_user).to eq(user)
        end
      end

      context "when searching case-insensitive by email using 'email_or_username: <email>'" do
        it 'returns the correct user' do
          found_user = described_class.find_for_database_authentication(email_or_username: email.upcase)
          expect(found_user).to eq(user)
        end
      end

      context "when searching case-insensitive by email using 'email: <email>'" do
        it 'returns the correct user when using :email' do
          found_user = described_class.find_for_database_authentication(email: email.upcase)
          expect(found_user).to be_nil
        end
      end

      context "when searching username using 'email_or_username: <username>' with invalid username" do
        it 'returns nil' do
          found_user = described_class.find_for_database_authentication(email_or_username: 'nonexistent')
          expect(found_user).to be_nil
        end
      end

      context "when searching email using 'email: <email>' with invalid email" do
        it 'returns nil' do
          found_user = described_class.find_for_database_authentication(email: 'wrong@example.com')
          expect(found_user).to be_nil
        end
      end

      context "when searching username using 'username: <username>' with invalid username" do
        it 'returns nil' do
          found_user = described_class.find_for_database_authentication(username: 'nonexistent')
          expect(found_user).to be_nil
        end
      end
    end
  end

  describe '#user_stores_by_name_and_zip_code?' do
    subject(:user) { create(:user) }

    before do
      user_stores.each do |store|
        user.user_stores.create(store: store)
      end
    end

    let(:user_stores) do
      stores = []

      stores << create(:store, store_name: 'CCC', zip_code: '55555')
      stores << create(:store, store_name: 'CCA', zip_code: '66666')
      stores << create(:store, store_name: 'BBB', zip_code: '44444')
      stores << create(:store, store_name: 'BBB', zip_code: '33333')
      stores << create(:store, store_name: 'AAA', zip_code: '22222')
      stores << create(:store, store_name: 'AAA', zip_code: '11111')

      stores
    end

    it 'returns the user stores by name and zip code' do
      sorted_user_stores = user.user_stores_by_name_and_zip_code
      expect(user_stores_eq?(sorted_user_stores[0].store, user_stores[5])).to be true
      expect(user_stores_eq?(sorted_user_stores[1].store, user_stores[4])).to be true
      expect(user_stores_eq?(sorted_user_stores[2].store, user_stores[3])).to be true
      expect(user_stores_eq?(sorted_user_stores[3].store, user_stores[2])).to be true
      expect(user_stores_eq?(sorted_user_stores[4].store, user_stores[1])).to be true
      expect(user_stores_eq?(sorted_user_stores[5].store, user_stores[0])).to be true
    end
  end

  describe '#user_store_exists?' do
    subject(:user) { create(:user, :with_stores) }

    it do
      expect(user.stores.count).not_to eq 0
    end

    context 'when the user store exists' do
      it 'returns true' do
        store = user.stores.first
        expect(user.user_store_exists?(store.id)).to be true
      end
    end

    context 'when the user store does not exist' do
      let(:another_user) { create(:user, :with_stores) }

      it do
        expect(another_user.stores.count).not_to eq 0
      end

      it 'returns true' do
        store = another_user.stores.first
        expect(user.user_store_exists?(store.id)).to be false
      end
    end
  end

  def user_stores_eq?(store1, store2)
    store1.store_name == store2.store_name &&
      store1.zip_code == store2.zip_code
  end
end
