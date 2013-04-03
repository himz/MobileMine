require 'spec_helper'

describe "cards/index" do
  before(:each) do
    assign(:cards, [
      stub_model(Card,
        :card_number => "Card Number",
        :cvv => "Cvv",
        :user => nil
      ),
      stub_model(Card,
        :card_number => "Card Number",
        :cvv => "Cvv",
        :user => nil
      )
    ])
  end

  xit "renders a list of cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Card Number".to_s, :count => 2
    assert_select "tr>td", :text => "Cvv".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
