require 'rails_helper'

RSpec.describe "stores/edit", type: :view do
  let(:store) {
    Store.create!(
      name: "MyString",
      street1: "MyString",
      street2: "MyString",
      city: "MyString",
      state: "MyString",
      zip_code: "MyString"
    )
  }

  before(:each) do
    assign(:store, store)
  end

  it "renders the edit store form" do
    render

    assert_select "form[action=?][method=?]", store_path(store), "post" do

      assert_select "input[name=?]", "store[name]"

      assert_select "input[name=?]", "store[street1]"

      assert_select "input[name=?]", "store[street2]"

      assert_select "input[name=?]", "store[city]"

      assert_select "input[name=?]", "store[state]"

      assert_select "input[name=?]", "store[zip_code]"
    end
  end
end
