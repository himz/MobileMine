require 'spec_helper'

describe "auctions/show" do
  before(:each) do
    @auction = assign(:auction, stub_model(Auction,
      :item_id => "",
      :seller_id => "",
      :bid_amount => "",
      :highest_bidder => "",
      :state => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
