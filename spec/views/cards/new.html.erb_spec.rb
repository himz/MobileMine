require 'spec_helper'

describe "cards/new" do
  before(:each) do
    assign(:card, stub_model(Card,
      :card_number => "MyString",
      :cvv => "MyString",
      :user => nil
    ).as_new_record)
  end

  xit "renders new card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cards_path, :method => "post" do
      assert_select "input#card_card_number", :name => "card[card_number]"
      assert_select "input#card_cvv", :name => "card[cvv]"
      assert_select "input#card_user", :name => "card[user]"
    end
  end
end
