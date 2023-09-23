# frozen_string_literal: true

RSpec.describe Store do
  describe 'associations' do
    it { is_expected.to belong_to(:state) }
    it { is_expected.to have_many(:user_stores) }
    it { is_expected.to have_many(:users).through(:user_stores) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:store_name).with_message("can't be blank") }
    it { is_expected.to validate_presence_of(:address).with_message("can't be blank") }
    it { is_expected.to validate_presence_of(:city).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:store_name).is_at_most(64) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:zip_code).case_insensitive.with_message('has already been taken') } # rubocop:disable Layout/LineLength
    it { is_expected.to validate_length_of(:address).is_at_most(64) }
    it { is_expected.to validate_length_of(:address2).is_at_most(64).allow_blank }
    it { is_expected.to validate_length_of(:city).is_at_most(64) }
    it { is_expected.to allow_value('12345').for(:zip_code) }
    it { is_expected.to allow_value('12345-6789').for(:zip_code) }
    it { is_expected.not_to allow_value('1234').for(:zip_code) }
    it { is_expected.not_to allow_value('abcd').for(:zip_code) }
    it { is_expected.not_to allow_value('12345-').for(:zip_code) }
    it { is_expected.not_to allow_value('12345-678a').for(:zip_code) }
    it { is_expected.not_to allow_value('1234567890').for(:zip_code) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      subject(:store) { build(:store, store_name: store_name, address: address, address2: address2) }

      before do
        store.save!
      end

      let(:store_name) { 'store name' }
      let(:address) { 'street 1' } # rubocop:disable RSpec/IndexedLet
      let(:address2) { 'street 2' } # rubocop:disable RSpec/IndexedLet

      it 'titleizes store_name' do
        expect(store.store_name).to eq(store_name.titleize)
      end

      it 'titleizes address' do
        expect(store.address).to eq(address.titleize)
      end

      it 'titleizes address2' do
        expect(store.address2).to eq(address2.titleize)
      end
    end
  end
end
