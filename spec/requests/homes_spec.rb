require 'spec_helper'

describe "Home" do

  describe "Title for home page is set" do
    it "Should have title BuyThisSellThat" do
      visit root_path
      page.should have_selector('title',:text => "Mobile Mine")
    end
  end




end


