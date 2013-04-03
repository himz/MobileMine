require 'spec_helper'

describe "auctions/index" do
  before(:each) do
    assign(:auctions, [
      stub_model(Auction,
        :item_id => "",
        :seller_id => "",
        :bid_amount => "",
        :highest_bidder => "",
        :state => 1
      ),
      stub_model(Auction,
        :item_id => "",
        :seller_id => "",
        :bid_amount => "",
        :highest_bidder => "",
        :state => 1
      )
    ])
  end

  xit "renders a list of auctions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
