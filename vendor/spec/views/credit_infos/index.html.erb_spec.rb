require 'spec_helper'

describe "credit_infos/index" do
  before(:each) do
    assign(:credit_infos, [
      stub_model(CreditInfo,
        :user_id => 1,
        :billing_address => "Billing Address",
        :credit_card_no => "Credit Card No",
        :zipcode => 2
      ),
      stub_model(CreditInfo,
        :user_id => 1,
        :billing_address => "Billing Address",
        :credit_card_no => "Credit Card No",
        :zipcode => 2
      )
    ])
  end

  it "renders a list of credit_infos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Billing Address".to_s, :count => 2
    assert_select "tr>td", :text => "Credit Card No".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
