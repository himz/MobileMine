require 'spec_helper'

describe "credit_infos/new" do
  before(:each) do
    assign(:credit_info, stub_model(CreditInfo,
      :user_id => 1,
      :billing_address => "MyString",
      :credit_card_no => "MyString",
      :zipcode => 1
    ).as_new_record)
  end

  it "renders new credit_info form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => credit_infos_path, :method => "post" do
      assert_select "input#credit_info_user_id", :name => "credit_info[user_id]"
      assert_select "input#credit_info_billing_address", :name => "credit_info[billing_address]"
      assert_select "input#credit_info_credit_card_no", :name => "credit_info[credit_card_no]"
      assert_select "input#credit_info_zipcode", :name => "credit_info[zipcode]"
    end
  end
end
