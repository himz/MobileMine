require 'spec_helper'

describe "Auctions" do
  describe "GET /auctions" do
    xit "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get auctions_path
      response.status.should be(200)
    end
  end
end
