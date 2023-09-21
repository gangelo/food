# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'stores/index' do
  before do
    assign(:stores, [
             Store.create!(
               name: 'Name',
               street1: 'Street 1',
               street2: 'Street 2',
               city: 'City',
               state: 'State',
               zip_code: 'Zip Code'
             ),
             Store.create!(
               name: 'Name',
               street1: 'Street 1',
               street2: 'Street 2',
               city: 'City',
               state: 'State',
               zip_code: 'Zip Code'
             )
           ])
  end

  it 'renders a list of stores' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Street 1'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Street 2'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('City'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('State'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Zip Code'.to_s), count: 2
  end
end
