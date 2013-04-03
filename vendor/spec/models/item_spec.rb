require 'spec_helper'

describe Item do
  #before do
   # @item = Item.new(name: "Celphone1", image_url: "someURL", price: "$500", availability: "Yes", description: "somedescrption",
   #              manufacturer: "somemanufacturer", sold_count: 0, featured: false)
  #end
  let(:item) { FactoryGirl.create(:item) }
  subject {item}


  it {should respond_to(:name)}
  it {should respond_to(:image_url)}
  it {should respond_to(:price)}
  it {should respond_to(:availability)}
  it {should respond_to(:description)}
  it {should respond_to(:manufacturer)}
  it {should respond_to(:sold_count)}
  it {should respond_to(:featured)}
  it {should respond_to(:user_id)}

  it "has a valid factory" do
    item.should be_valid
  end


  context "Validations" do

    describe "when name is not present" do
      before { item.name = nil }
      it { should_not be_valid }
    end

    describe "when image_url is not present" do
      before { item.image_url = " " }
      it { should_not be_valid }
    end

    describe "when price is not present" do
      before { item.price = nil }
      it { should_not be_valid }
    end

    describe "when price is not number" do
      before { item.price = "hello" }
      it { should_not be_valid }
    end

    describe "when availability is not present" do
      before { item.availability = " " }
      it { should_not be_valid }
    end

    describe "when description is not present" do
      before { item.description = " " }
      it { should_not be_valid }
    end

    describe "when manufacturer is not present" do
      before { item.manufacturer = nil }
      it { should_not be_valid }
    end

    describe "when manufacturer is not present" do
      before { item.manufacturer = "apple" }
      it { should be_valid }
    end

    describe "when sold_count is not present" do
      before { item.sold_count = "" }
      it { should_not be_valid }
    end

    describe "when sold_count is not number" do
      before { item.sold_count = "sdfs" }
      it { should_not be_valid }
    end

    describe "when sold count is zero" do
      before { item.sold_count = 0 }
      it { should be_valid }
    end

    describe "when featured is not present" do
      before { item.featured = "" }
      it { should_not be_valid }
    end



    describe "when user_id is not present" do
      before { item.user_id = "" }
      it { should_not be_valid }
    end


    describe "when user_id is an integer" do
      before { item.user_id = 12 }
      it { should be_valid }
    end


  end


  it "changes the number of items when adding a New item" do

    @item=Item.new(name: "Celphone13", image_url: "someURL", price: "500", availability: "Yes", description: "somedescrption",
                  manufacturer: "somemanufacturer", sold_count: 0, featured: true, user_id:1)

    expect {@item.save}.to change {Item.count}.by(1)
  end
end

