# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stores/new' do
  before do
    assign(:store, Store.new(
                     name: 'MyString',
                     address: 'MyString',
                     address2: 'MyString',
                     city: 'MyString',
                     state: 'MyString',
                     zip_code: 'MyString'
                   ))
  end

  it 'renders new store form' do
    render

    assert_select 'form[action=?][method=?]', stores_path, 'post' do
      assert_select 'input[name=?]', 'store[name]'

      assert_select 'input[name=?]', 'store[address]'

      assert_select 'input[name=?]', 'store[address2]'

      assert_select 'input[name=?]', 'store[city]'

      assert_select 'input[name=?]', 'store[state]'

      assert_select 'input[name=?]', 'store[zip_code]'
    end
  end
end
