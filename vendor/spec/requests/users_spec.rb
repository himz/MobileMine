require 'spec_helper'

describe "User" do

  let(:user) { FactoryGirl.create(:user) }

  describe "sign up" do

    it "doesn't fill the appropriate fields to create a new user "   do
    visit new_user_registration_path
    fill_in "user_first_name", with: user.first_name
    click_button "Sign up"
    page.should have_content "errors"
    page.should_not have_content "First name can't be blank"
    page.should have_content "Last name can't be blank"

    end


    it "fills all the  appropriate fields to create a new user "   do
      visit new_user_registration_path
      fill_in "user_first_name", with: user.first_name
      fill_in "user_last_name", with: user.last_name
      fill_in "user_phone_number", with: user.phone_number
      fill_in "user_address", with: user.address
      fill_in "user_zipcode", with: user.zipcode
      fill_in "user_email", with: "amigo@amigo.com"
      fill_in "user_password", with: user.password
      fill_in "user_password_confirmation", with: user.password
      click_button "Sign up"
      page.should_not have_content("First name can't be blank")
      page.should_not have_content("Last name can't be blank")
      page.should_not have_content("Phone number is too short (minimum is 8 characters)")
      page.should_not have_content("Email is invalid")
      page.should_not have_content("Email can't be blank")
      page.should_not have_content("Password can't be blank")
      page.should_not have_content("Zipcode is the wrong length (should be 5 characters)")
      page.should_not have_content("Email has already been taken")
      page.should_not have_content("Zipcode can't be blank")
      page.should_not have_content("Zipcode is not a number")
      page.should_not have_content("errors")
        page.should have_content "Home"

    end
  end

  it "logs in unsuccessfully" do

    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "wrong password"
    click_button "Sign in"
    page.should have_content "Invalid email or password"

  end

  it "logs in successfully" do

    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
    page.should have_content "Welcome "+user.first_name

  end

  describe "functionalities when the user is logged in" do
    before (:each) do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Sign in"
    end
    it "can see his profile" do
      visit users_show_path
      page.should have_content user.first_name
    end

    it "can see the edit page of his information" do
      visit edit_user_registration_path
      fill_in "user_first_name", with: "testname"
      fill_in "user_current_password", with: user.password
      fill_in "user_password_confirmation", with: user.password

      fill_in "user_password", with: user.password


      click_button "Update"
      page.should have_content "testname"

    end

    it "can see the edit page of his information succesfully" do
      visit edit_user_registration_path
      page.should have_content user.first_name

    end
    it "logs out successfully" do
      page.should have_content "Welcome "+user.first_name
      visit destroy_user_session_path
      page.should_not have_content user.first_name
    end
    it "can see his profile" do
      visit users_profile_path
      page.should have_content "View User Information"
    end

  end

end