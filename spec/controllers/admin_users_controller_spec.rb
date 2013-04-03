require 'spec_helper'
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end
describe AdminUsersController do

  let(:user) { FactoryGirl.create(:admin_user) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end


  describe "#index" do

    it { should respond_to(:index)}

    it "return http success" do
      get 'index'
      response.should be_success
    end

    it "assigns all items as @users" do
      users= User.all
      get :index
      assigns(:users).should eq(users)
    end

    it "calls paginate from Users" do
      User.should_receive(:paginate)
      get :index

    end


    it "renders the view" do
      get :index
      response.should render_template :index

    end

  end

  describe "#show" do

    it { should respond_to(:show)}

    it "assigns the requested user as @user" do
      get :show, id: user.id
      assigns(:user).should eq(user)
    end


    it "calls find" do
      User.should_receive(:find)
      get :show, id: user.id

    end

    it "http response should succeed" do
      get :show, id: user.id
      response.should be_success
    end

    it "renders the view" do
      get :show, id: user.id
      response.should render_template :show
    end
  end

  describe "#delete" do
    it { should respond_to(:delete)}

    it "deletes the user" do
      @user = User.new(first_name: "name", last_name: "lastn", zipcode: 12345, address: "address", email: "somedescrption@some.com",
                       phone_number: "224324234334", user_type: 1, password: "randomep")

      @user.save
      expect{
        delete :delete, id: @user.id
      }.to change(User,:count).by(-1)
    end


    it "redirects to admin_users#index" do
      delete :delete, id:user.id
      response.should redirect_to admin_users_index_url
    end

  end

  describe "#deactivate" do
    it { should respond_to(:deactivate)}

    it "deactivates the user" do
      get :deactivate, id:user.id
      userDeactivated=User.find(user.id)
      userDeactivated.activated.should be_false

    end

  end

  describe "#activate" do
    it { should respond_to(:activate)}

    it "activates the user" do
      get :activate, id:user.id
      userActivated=User.find(user.id)
      userActivated.activated.should be_true
    end
  end
end
