require 'spec_helper'

describe Auction do



  before do
  @item=Item.new(name: "Celphone13", image_url: "someURL", price: 500, availability: 9, description: "somedescrption",
                 manufacturer: "somemanufacturer", sold_count: 0, featured: true, user_id:1, auction_flag: false)
  @item.save
  end
=begin
  auction=Auction.new(item_id: @item.id, seller_id: 1, bid_amount: 100, state: 0,end_time: Time.now+60*5)
  auction.save
=end
 # let(:item) { FactoryGirl.create(:item) }
  let(:auction) { FactoryGirl.create(:auction) }
  #let(:item) { FactoryGirl.create(:item) }




  subject {auction}

  it { should respond_to(:bid_amount)}
  it { should respond_to(:highest_bidder)}
  it { should respond_to(:item_id)}
  it { should respond_to(:seller_id)}
  it { should respond_to(:state)}
  it { should respond_to(:end_time)}

  context "Validations" do

    it "has a valid factory" do
      auction.should be_valid
    end

    describe "When bid amount is null" do
      before { auction.bid_amount = nil }
      it { should_not be_valid }
    end

    describe "When bid amount is not null" do
      before { auction.bid_amount = 100 }
      it { should be_valid }
    end

    describe "When bid amount is not number" do
      before { auction.bid_amount = "sdsd" }
      it { should_not be_valid }
    end

    describe "When end time is null" do
      before { auction.end_time = nil }
      it { should_not be_valid }
    end

    describe "When end time is not null" do
      before { auction.end_time = Time.now+5*60 }
      it { should be_valid }
    end

    describe "when state is not present" do
      before { auction.state = " " }
      it { should_not be_valid }
    end

    describe "when state is not an integer" do
      before { auction.state = "hello" }
      it { should_not be_valid }
    end

    describe "when state is > 4" do
      before { auction.state = 5 }
      it { should_not be_valid }
    end

    describe "when state is < 0" do
      before { auction.state = -1 }
      it { should_not be_valid }
    end

    describe "when state is = 0" do
      before { auction.state = 1 }
      it { should be_valid }
    end

    describe "when seller id is not present" do
      before { auction.seller_id = " " }
      it { should_not be_valid }
    end

    describe "when seller id should be an integer" do
      before { auction.seller_id = "hello" }
      it { should_not be_valid }
    end

    describe "when item id is not present" do
      before { auction.item_id = " " }
      xit { should_not be_valid }
    end

    describe "when item id should be an integer" do
      before { auction.item_id = "hello" }
      xit { should_not be_valid }
    end

  end
end



