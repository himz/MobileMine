require 'spec_helper'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end



describe "Cards" do


  describe "GET /cards" do
    xit "works! " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get cards_path
      response.status.should be(200)
    end
  end
end
