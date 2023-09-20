require 'rails_helper'

RSpec.describe "stores/show", type: :view do
  before(:each) do
    assign(:store, Store.create!(
      name: "Name",
      street1: "Street 1",
      street2: "Street 2",
      city: "City",
      state: "State",
      zip_code: "Zip Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Street 1/)
    expect(rendered).to match(/Street 2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip Code/)
  end
end
