require 'spec_helper'
    RSpec.configure do |config|
      config.include Devise::TestHelpers, :type => :controller
    end

    def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = FactoryGirl.create(:user)
        sign_in user
      end
    end

      def login_seller
        before(:each) do
          @request.env["devise.mapping"] = Devise.mappings[:seller]
          seller = FactoryGirl.create(:seller)
          sign_in seller
        end
      end


describe ItemsController do

  let(:item) { FactoryGirl.create(:item) }
  let(:user) { FactoryGirl.create(:user) }
  let(:seller) { FactoryGirl.create(:seller) }

  it "has a valid factory for user" do
    user.should be_valid
  end

  it "has a valid factory for seller" do
    seller.should be_valid
  end

  it "has a valid factory for item" do
    item.should be_valid
  end

  describe "#index" do

    it { should respond_to(:index)}

    it "return http success" do
      get 'index'
      response.should be_success
    end

    it "assigns all items as @items" do
      items= Item.all
      get :index
      assigns(:items).should eq(items)
    end




    it "calls all from Item" do
      Item.should_receive(:where)
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

  describe "admin" do
    xit "should call create on Item when POST create is called" do
      item = mock_model(Item, :attributes= => true, :save => true)
      Item.stub(:new) { item }
      post :create,  :item => {}
      response.should redirect_to(admin_show_path(item))
    end
  end

  describe "#create" do
    login_seller
    it {should respond_to(:create)}

    xit "should call create on Item when POST create is called" do

      post :create,  item: FactoryGirl.attributes_for(:item)
      response.should redirect_to(item)
    end




    context "with valid attributes" do
      xit "save the new item in the database"   do
        expect{
        post :create, item: FactoryGirl.attributes_for(:item)
        }.to change(Item,:count).by(1)



      end

    end


    context "with invalid attributes" do
      it "does not save the new item in the database"   do
        expect{
          post :create, item: FactoryGirl.attributes_for(:invalid_item)
        }.to_not change(Item,:count)
      end

      xit " should render new"  do
        post :create, item: FactoryGirl.attributes_for(:invalid_item)
        response.should render_template :new_item
      end
    end
  end








  describe "#update" do

    it {should respond_to(:update)}


    xit "locates the requested item" do
      put :update, id: item.id, item: item
      assigns(:item).should eq(item)
    end


    context "with valid attributes" do




     it "changes item attributes" do

        item.update_attribute(:name, "updateditem")
        put :update, id: item.id, item: item

        item.name.should eq("updateditem")
      end

    end
    context "with invalid attributes" do


      it "does not change item attributes" do
        put :update, id: item, item: FactoryGirl.attributes_for(:item, name: nil)
        item.reload
        item.name.should eq("Galaxy S2")
      end
    end



  end


  describe "#user_items_list" do
    login_user

    it { should respond_to(:user_items_list)}


    it "calls find" do
      Item.should_receive(:find_all_by_user_id)
      get :user_items_list, id: item.id

    end

    it "http response should succeed" do
      get :user_items_list, id: item.id
      response.should be_success
    end

    it "renders the view" do
      get :user_items_list, id: item.id
      response.should render_template :user_items_list
    end
  end

  describe "#user_edit_item" do
    login_user

    it { should respond_to(:user_edit_item)}




    it "http response should succeed" do
      get :user_edit_item, id: item.id
      response.should be_success
    end

    it "renders the view" do
      get :user_edit_item, id: item.id
      response.should render_template :user_edit_item
    end
  end

  describe "#new_item" do
    login_user

    it { should respond_to(:new_item)}


    it "calls find" do
      Item.should_receive(:new)
      get :new_item

    end

    it "http response should succeed" do
      get :new_item, id: item.id
      response.should be_success
    end

    it "renders the view" do
      get :new_item, id: item.id
      response.should render_template :new_item
    end
  end

  describe "#user_delete_item" do
    login_user

    it { should respond_to(:user_delete_item)}

    it "deletes the item" do
      @item = Item.new(name: "Celphone1", image_url: "someURL", price: "500", availability: "Yes", description: "somedescrption",
                       manufacturer: "somemanufacturer", sold_count: 0, featured: true, user_id: 1)
      @item.save
      expect{
        delete :user_delete_item, id: @item.id
      }.to change(Item,:count).by(-1)
    end


    it "redirects to Item#index" do
      delete :user_delete_item, id:item.id
      response.should redirect_to user_items_index_url
    end
  end


end
