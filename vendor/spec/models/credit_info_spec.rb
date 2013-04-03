require 'spec_helper'

describe CreditInfo do
  let(:credit_card_info) { FactoryGirl.create(:credit_info) }
  subject {credit_card_info}

  it {should respond_to(:billing_address)}
  it {should respond_to(:credit_card_no)}
  it {should respond_to(:user_id)}
  it {should respond_to(:zipcode)}

  context "Validations" do

    it "has a valid factory" do
      credit_card_info.should be_valid
    end

    describe "when billing address is not present" do
      before { credit_card_info.billing_address = nil }
      it { should_not be_valid }
    end

    describe "when credit_card_no is not present" do
      before { credit_card_info.credit_card_no = nil }
      it { should_not be_valid }
    end

    describe "when credit_card_no is <16 digits" do
      before { credit_card_info.credit_card_no = "123456781234567" }
      it { should_not be_valid }
    end

    describe "when credit_card_no is >16 digits" do
      before { credit_card_info.credit_card_no = "12345678123456789" }
      it { should_not be_valid }
    end

    describe "when credit_card_no is 16 digits" do
      before { credit_card_info.credit_card_no = "1234567812345678" }
      it { should be_valid }
    end

    describe "when user id is not present" do
      before { credit_card_info.user_id = nil }
      it { should_not be_valid }
    end

    describe "when user id should be an integer" do
      before { credit_card_info.user_id = "hello" }
      it { should_not be_valid }
    end

    describe "when user id should be an integer" do
      before { credit_card_info.user_id = 1 }
      it { should be_valid }
    end

    describe "when zipcode is not present" do
      before { credit_card_info.zipcode = nil }
      it { should_not be_valid }
    end

    describe "when zipcode is not an integer" do
      before { credit_card_info.zipcode = "hello" }
      it { should_not be_valid }
    end

    describe "when zipcode is less than 5 digits" do
      before { credit_card_info.zipcode = 1234 }
      it { should_not be_valid }
    end

    describe "when zipcode is greater than 5 digits" do
      before { credit_card_info.zipcode = 123456 }
      it { should_not be_valid }
    end

    describe "when zipcode is 5 digits" do
      before { credit_card_info.zipcode = 12345 }
      it { should be_valid }
    end

  end
end
