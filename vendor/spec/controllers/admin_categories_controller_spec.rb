require 'spec_helper'

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

describe AdminCategoriesController do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:admin_user)}

  it "has a valid category factory" do
    category.should be_valid
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
  it { should respond_to(:index)}

  it "return http success" do
    #login_user
    get 'index'
    response.should be_success
  end

  it "assigns all categories as @categories" do
    categories= Category.all
    get :index
    assigns(:categories).should eq(categories)
  end

  it "calls all from Categories" do
    Category.should_receive(:all)
    get :index

  end


  it "renders the view" do
    get :index
    response.should render_template :index

  end

  describe "#show" do

    it { should respond_to(:show)}

    it "assigns the requested category as @category" do
      get :show, id: category.id
      assigns(:category).should eq(category)
    end


    it "calls find" do
      Category.should_receive(:find)
      get :show, id: category.id

    end

    it "http response should succeed" do
      get :show, id: category.id
      response.should be_success
    end

    it "renders the view" do
      get :show, id: category.id
      response.should render_template :show
    end
  end

  describe "#delete" do
    it { should respond_to(:delete)}

    it "deletes the category" do
      @category = Category.new(name: "Smart Phone", image_url: "someURL" )

      @category.save
      expect{
        delete :delete, id: @category.id
      }.to change(Category,:count).by(-1)
    end


    it "redirects to admin_categorys#index" do
      delete :delete, id:category.id
      response.should redirect_to admin_category_index_url
    end

  end

end

