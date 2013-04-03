require "spec_helper"

describe CreditInfosController do
  describe "routing" do

    it "routes to #index" do
      get("/credit_infos").should route_to("credit_infos#index")
    end

    it "routes to #new" do
      get("/credit_infos/new").should route_to("credit_infos#new")
    end

    it "routes to #show" do
      get("/credit_infos/1").should route_to("credit_infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/credit_infos/1/edit").should route_to("credit_infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/credit_infos").should route_to("credit_infos#create")
    end

    it "routes to #update" do
      put("/credit_infos/1").should route_to("credit_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/credit_infos/1").should route_to("credit_infos#destroy", :id => "1")
    end

  end
end
