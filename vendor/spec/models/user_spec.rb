require 'spec_helper'

describe User do


  let(:user) { FactoryGirl.create(:user) }
  subject {user}

  it {should respond_to(:phone_number)}
  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}
  it {should respond_to(:user_type)}
  it {should respond_to(:address)}
  it {should respond_to(:zipcode)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}


  context "Validations" do

    it "has a valid factory" do
        user.should be_valid
    end


    describe "when first_name is present" do
      before { user.first_name = "man" }
      it { should be_valid }
    end


    describe "when first_name is not present" do
      before { user.first_name = " " }
      it { should_not be_valid }
    end

    describe "when Last_name present" do
      before { user.last_name = "lasttest" }
      it { should be_valid }
    end

    describe "when Last_name is not present" do
      before { user.last_name = " " }
      it { should_not be_valid }
    end

    describe "when user_type is present" do
      before { user.user_type = 1 }
      it { should be_valid }
    end

    describe "when user_type is not present" do
      before { user.user_type = nil }
      it { should_not be_valid }
    end

    describe "when user_type is not an integer" do
      before { user.user_type = "hello" }
      it { should_not be_valid }
    end

    describe "when a valid zipcode is present" do
      before { user.zipcode = nil }
      it { should_not be_valid }
    end

    describe "when zipcode is not present" do
      before { user.zipcode = nil }
      it { should_not be_valid }
    end

    describe "when zipcode is not integer" do
      before { user.zipcode = "zipcodetest" }
      it { should_not be_valid }
    end

    describe "when a valid email is present" do
      before { user.email = "mymail@mydomain.com" }
      it { should be_valid }
    end
    describe "when email is not present" do
      before { user.email = " " }
      it { should_not be_valid }
    end
    describe "when email address doesn't follow an email pattern" do

      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          user.email = invalid_address
          user.should_not be_valid
        end
      end
    end

    describe "when a  valid password is present" do
      before { user.password = "dsfsdfdsf" }
      it { should be_valid }
    end


  end


end
