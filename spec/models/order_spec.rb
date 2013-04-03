require 'spec_helper'

describe Order do

  let(:order) { FactoryGirl.create(:order) }
  subject {order}

  it {should respond_to(:buyer_id)}
  it {should respond_to(:item_id)}
  it {should respond_to(:seller_id)}
  it {should respond_to(:state)}

  it "has a valid factory" do
    order.should be_valid
  end

  context "Validations" do

    describe "when buyer id is not present" do
      before { order.buyer_id = " " }
      it { should_not be_valid }
    end

    describe "when buyer id should be an integer" do
      before { order.buyer_id = "hello" }
      it { should_not be_valid }
    end

    describe "when seller id is not present" do
      before { order.seller_id = " " }
      it { should_not be_valid }
    end

    describe "when seller id should be an integer" do
      before { order.seller_id = "hello" }
      it { should_not be_valid }
    end

    describe "when item id is not present" do
      before { order.item_id = " " }
      it { should_not be_valid }
    end

    describe "when item id should be an integer" do
      before { order.item_id = "hello" }
      it { should_not be_valid }
    end

    describe "when state is not present" do
      before { order.state = " " }
      it { should_not be_valid }
    end

    describe "when state is not an integer" do
      before { order.state = "hello" }
      it { should_not be_valid }
    end

    describe "when state is > 4" do
      before { order.state = 5 }
      it { should_not be_valid }
    end

    describe "when state is < 0" do
      before { order.state = -1 }
      it { should_not be_valid }
    end

    describe "when state is = 0" do
      before { order.state = 1 }
      it { should be_valid }
    end

  end
end
