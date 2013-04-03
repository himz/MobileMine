require 'spec_helper'
require "item"


describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it { should respond_to(:index)}

    it "assigns all categories as @categories" do
      categories= Category.all
      get :index
      assigns(:categories).should eq(categories)
    end

    it "assigns @popular items" do
      get :index
      assigns(:popular).should_not be_nil
    end

    it "assigns @featured items" do
      get :index
      assigns(:featured).should_not be_nil
    end


  end


  describe "Validations" do


    it "popular items array should have 4 or fewer items" do
      get :index
      assigns(:categories).count.should   <= 4
    end

    it "featured items array should have 4 or fewer items" do
      get :index
      assigns(:featured).count.should   <= 4
    end
  end

end
