require 'spec_helper'

describe "credit_infos/edit" do
  before(:each) do
    @credit_info = assign(:credit_info, stub_model(CreditInfo,
      :user_id => 1,
      :billing_address => "MyString",
      :credit_card_no => "MyString",
      :zipcode => 1
    ))
  end

  it "renders the edit credit_info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credit_infos_path(@credit_info), :method => "post" do
      assert_select "input#credit_info_user_id", :name => "credit_info[user_id]"
      assert_select "input#credit_info_billing_address", :name => "credit_info[billing_address]"
      assert_select "input#credit_info_credit_card_no", :name => "credit_info[credit_card_no]"
      assert_select "input#credit_info_zipcode", :name => "credit_info[zipcode]"
    end
  end
end
