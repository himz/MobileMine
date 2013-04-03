require 'spec_helper'

describe "Home" do
  describe "home/index.html.erb" do
    xit "Home page should be a index page" do
      visit root_path
      page.should have_content('Welcome to buythissellthat')
    end
  end

  describe "Title for home page is set" do
    xit "Should have title buythissellthat" do
      visit root_path
      page.should have_selector('title',:text => "buythissellthat")
    end
  end
end

