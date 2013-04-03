require 'spec_helper'

describe "credit_infos/show" do
  before(:each) do
    @credit_info = assign(:credit_info, stub_model(CreditInfo,
      :user_id => 1,
      :billing_address => "Billing Address",
      :credit_card_no => "Credit Card No",
      :zipcode => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Billing Address/)
    rendered.should match(/Credit Card No/)
    rendered.should match(/2/)
  end
end
