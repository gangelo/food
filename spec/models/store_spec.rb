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

    context 'when the store name is unique within zip code' do
      before do
        create(:store, store_name: store_name, zip_code: '12345')
      end

      let(:store_name) { 'store name' }

      it 'saves a store with the same name' do
        store = build(:store, store_name: store_name, zip_code: '67890')
        expect(store).to be_valid
      end
    end

    context 'when the store name is not unique within zip code' do
      before do
        create(:store, store_name: store_name, zip_code: zip_code)
      end

      let(:store_name) { 'store name' }
      let(:zip_code) { '12345' }

      it 'saves a store with the same name' do
        store = build(:store, store_name: store_name, zip_code: zip_code)
        expect(store).to_not be_valid
      end
    end
  end

  describe 'callbacks' do
    describe '.before_save' do
      subject(:store) { build(:store, store_name: store_name, address: address, address2: address2) }

      before do
        store.save!
      end

      let(:store_name) { 'store name' }
      let(:address) { 'street 1' }
      let(:address2) { 'street 2' }

      it 'capitalizes the first letter of store_name' do
        expected_store_name = "#{store_name[0].upcase}#{store_name[1..]}"
        expect(store.store_name).to eq(expected_store_name)
      end

      it 'titleizes address' do
        expect(store.address).to eq(address.titleize)
      end

      it 'titleizes address2' do
        expect(store.address2).to eq(address2.titleize)
      end
    end
  end

  describe '#unique_store?' do
    subject(:store) { create(:store) }

    context 'when the store name is unique within zip code' do
      it 'returns true' do
        non_unique_store = build(:store, store_name: store.store_name, zip_code: '07001')
        expect(non_unique_store.unique_store?).to be true
      end
    end

    context 'when the store name is not unique within zip code' do
      it 'returns false' do
        non_unique_store = build(:store, store_name: store.store_name, zip_code: store.zip_code)
        expect(non_unique_store.unique_store?).to be false
      end
    end

    context 'when store_name is blank' do
      it 'returns true' do
        non_unique_store = build(:store, store_name: '', zip_code: store.zip_code)
        expect(non_unique_store.unique_store?).to be true
      end
    end

    context 'when comparing itself' do
      it 'returns true' do
        expect(store.unique_store?).to be true
      end
    end
  end

  describe '#non_unique_store?' do
    subject(:store) { create(:store) }

    context 'when the store name is unique within zip code' do
      it 'returns false' do
        non_unique_store = build(:store, store_name: store.store_name, zip_code: '07001')
        expect(non_unique_store.non_unique_store?).to be false
      end
    end

    context 'when the store name is not unique within zip code' do
      it 'returns true' do
        non_unique_store = build(:store, store_name: store.store_name, zip_code: store.zip_code)
        expect(non_unique_store.non_unique_store?).to be true
      end
    end
  end
end
