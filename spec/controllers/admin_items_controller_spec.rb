require 'spec_helper'
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end



describe AdminItemsController do
  let(:item) { FactoryGirl.create(:item) }
  let(:user) { FactoryGirl.create(:admin_user)}

  before(:each) do
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in user
  end


  it "has a valid item factory" do
    item.should be_valid
  end

  describe "#index" do

    it { should respond_to(:index)}

    it "return http success" do
      #login_user
      get 'index'
      response.should be_success
    end

    it "assigns all items as @items" do
      items= Item.all
      get :index
      assigns(:items).should eq(items)
    end

    it "calls paginate from Items" do
      Item.should_receive(:paginate)
      get :index

    end


    it "renders the view" do
      get :index
      response.should render_template :index

    end

  end

  describe "#show" do

    it { should respond_to(:show)}

    it "assigns the requested item as @item" do
      get :show, id: item.id
      assigns(:item).should eq(item)
    end


    it "calls find" do
      Item.should_receive(:find)
      get :show, id: item.id

    end

    it "http response should succeed" do
      get :show, id: item.id
      response.should be_success
    end

    it "renders the view" do
      get :show, id: item.id
      response.should render_template :show
    end
  end

  describe "#delete" do
    it { should respond_to(:delete)}

    it "deletes the item" do
      @item=Item.new(name: "Celphone13", image_url: "someURL", price: "500", availability: "Yes", description: "somedescrption",
                     manufacturer: "somemanufacturer", sold_count: 0, featured: true, user_id: user.id )

      @item.save
      expect{
        delete :delete, id: @item.id
      }.to change(Item,:count).by(-1)
    end


    it "redirects to admin_items#index" do
      delete :delete, id:item.id
      response.should redirect_to admin_items_index_url
    end

  end

  describe "#deactivate" do
    it { should respond_to(:deactivate)}

    it "deactivates the item" do
      get :deactivate, id:item.id
      itemDeactivated=Item.find(item.id)
      itemDeactivated.activated.should be_false

    end

  end

  describe "#activate" do
    it { should respond_to(:activate)}

    it "activates the item" do
      get :activate, id:item.id
      itemActivated=Item.find(item.id)
      itemActivated.activated.should be_true
    end
  end
end
