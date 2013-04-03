require 'spec_helper'

describe "Items" do

  let(:item) { FactoryGirl.create(:item) }

  describe "details of item" do
     it "I should get a page"   do
      get item_path(item)
      response.status.should be(200)
     end

     it "should have the name of the item" do
      visit item_path(item)
      page.should have_content(item.name)

     end

     it "should have the description of the item" do
       visit item_path(item)
       page.should have_content(item.description)

     end

     it "should have the manufacturer of the item" do
       visit item_path(item)
       page.should have_content(item.manufacturer)

     end


     it "should have the price of the item" do
       visit item_path(item)
       page.should have_content(item.price)

     end

     it "should have the availability of the item" do
       visit item_path(item)
       page.should have_content(item.availability)

     end
  end

  describe "search item" do
    it "fields the search box with the word samsung and should get it in the result"   do
      visit home_index_path
      fill_in "search[name_contains]", with: item.name
      click_button "Search"
      page.should have_content item.price
      page.should have_content item.name
      page.should have_content item.availability


    end
  end
end
