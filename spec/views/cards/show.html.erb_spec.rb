require 'spec_helper'

describe "cards/show" do
  before(:each) do
    @card = assign(:card, stub_model(Card,
      :card_number => "Card Number",
      :cvv => "Cvv",
      :user => nil
    ))
  end

  xit "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Card Number/)
    rendered.should match(/Cvv/)
    rendered.should match(//)
  end
end
