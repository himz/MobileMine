require 'spec_helper'

describe Card do
  let(:card) { FactoryGirl.create(:card) }
   subject {card}

   it {should respond_to(:card_number)}
   it {should respond_to(:cvv)}
   it {should respond_to(:user_id)}
   it {should respond_to(:expiry_date)}

context "Validations" do  
 
  describe "when credit_card_no is <16 digits" do
    before { card.card_number = "123456781234567" }
    it { should_not be_valid }
  end

  describe "when credit_card_no is >16 digits" do
    before { card.card_number = "12345678123456789" }
    it { should_not be_valid }
  end

  describe "when credit_card_no is 16 digits" do
    before { card.card_number = "1234567812345678" }
    it { should be_valid }
  end

  describe "when user id is not present" do
    before { card.user_id = nil }
    it { should_not be_valid }
  end
  describe "when user id should be an integer" do
       before { card.user_id = "hello" }
       it { should_not be_valid }
   end

   describe "when user id should be an integer" do
       before { card.user_id = 1 }
       it { should be_valid }
   end
   describe "when cvv is not present" do
     before { card.cvv = nil }
     it { should_not be_valid }
   end
   describe "when cvv is <3 digits" do
         before { card.cvv = "12" }
         it { should_not be_valid }
       end

       describe "when cvv is >4 digits" do
         before { card.cvv = "12345" }
         it { should_not be_valid }
       end

       describe "when card is 3 digits" do
         before { card.cvv = "123" }
         it { should be_valid }
       end
  

  it "has a valid card number" do
    FactoryGirl.build(:card).should be_valid
  end
  it "is invalid with wrong card number" do
    FactoryGirl.build(:card, card_number: "1234").should_not be_valid
  end
  it "has a valid cvv number" do
    FactoryGirl.build(:card, cvv: "321").should be_valid
  end
  it "has a invalid cvv number" do
     FactoryGirl.build(:card, cvv: "3212323").should_not be_valid
   end  
  it "has a valid Expiry date" do
    FactoryGirl.build(:card, expiry_date: Date.today + 1).should be_valid
  end
  it "has a invalid Expiry date" do
    FactoryGirl.build(:card, expiry_date: "1999-11-21").should_not be_valid
  end
  
end
end
