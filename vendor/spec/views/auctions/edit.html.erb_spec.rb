require 'spec_helper'

describe "auctions/edit" do
  before(:each) do
    @auction = assign(:auction, stub_model(Auction,
      :item_id => "",
      :seller_id => "",
      :bid_amount => "",
      :highest_bidder => "",
      :state => 1
    ))
  end

  xit "renders the edit auction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auctions_path(@auction), :method => "post" do
      assert_select "input#auction_item_id", :name => "auction[item_id]"
      assert_select "input#auction_seller_id", :name => "auction[seller_id]"
      assert_select "input#auction_bid_amount", :name => "auction[bid_amount]"
      assert_select "input#auction_highest_bidder", :name => "auction[highest_bidder]"
      assert_select "input#auction_state", :name => "auction[state]"
    end
  end
end
