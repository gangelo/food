# frozen_string_literal: true

RSpec.describe Store do
  describe 'associations' do
    it { is_expected.to belong_to(:state) }
    it { is_expected.to have_many(:user_stores) }
    it { is_expected.to have_many(:users).through(:user_stores) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:store_name).with_message("can't be blank") }
    it { is_expected.to validate_presence_of(:street1).with_message("can't be blank") }
    it { is_expected.to validate_presence_of(:city).with_message("can't be blank") }
    it { is_expected.to validate_length_of(:store_name).is_at_most(64) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:zip_code).case_insensitive.with_message('has already been taken') } # rubocop:disable Layout/LineLength
    it { is_expected.to validate_length_of(:street1).is_at_most(64) }
    it { is_expected.to validate_length_of(:street2).is_at_most(64).allow_blank }
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
      subject(:store) { build(:store, store_name: store_name, street1: street1, street2: street2) }

      before do
        store.save!
      end

      let(:store_name) { 'store name' }
      let(:street1) { 'street 1' } # rubocop:disable RSpec/IndexedLet
      let(:street2) { 'street 2' } # rubocop:disable RSpec/IndexedLet

      it 'titleizes store_name' do
        expect(store.store_name).to eq(store_name.titleize)
      end

      it 'titleizes street1' do
        expect(store.street1).to eq(street1.titleize)
      end

      it 'titleizes street2' do
        expect(store.street2).to eq(street2.titleize)
      end
    end
  end
end
