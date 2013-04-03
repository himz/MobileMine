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

describe OrdersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order) }
  let(:item) { FactoryGirl.create(:item) }
  it "has a valid factory" do
    order.should be_valid
  end
  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
    :buyer_id => 1,
    :seller_id => 1,
    :item_id => 1,
    :state => 1,
    :billing_address => "somewhere in earth"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrdersController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    xit "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index, {}, valid_session
      assigns(:orders).should eq([order])
    end
  end

  describe "GET show" do
    xit "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end

  describe "GET edit" do
    xit "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :edit, {:id => order.to_param}, valid_session
      assigns(:order).should eq(order)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      login_user
      xit "creates a new Order" do #TODO: Fix the test
        expect {
          post :create, item: item.id, credit_card_no: "1234567812345678", billing_address: "test", zipcode: 12345#, order: FactoryGirl.attributes_for(:order)
        }.to change(Order, :count).by(1)
      end

      xit "assigns a newly created order as @order" do #TODO: Fix the test
        post :create, item:item.id#, order: FactoryGirl.attributes_for(:order)
        assigns(:order).should be_a(Order)
        assigns(:order).should be_persisted
      end

    end

  end

  #TODO: We should implement stories for these functions
  describe "PUT update" do
    describe "with valid params" do
      xit "updates the requested order" do
        order = Order.create! valid_attributes
        # Assuming there are no other orders in the database, this
        # specifies that the Order created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Order.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => order.to_param, :order => {'these' => 'params'}}, valid_session
      end

      xit "assigns the requested order as @order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}, valid_session
        assigns(:order).should eq(order)
      end

      xit "redirects to the order" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => valid_attributes}, valid_session
        response.should redirect_to(order)
      end
    end

    describe "with invalid params" do
      xit "assigns the order as @order" do
        order = Order.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {}}, valid_session
        assigns(:order).should eq(order)
      end

      xit "re-renders the 'edit' template" do
        order = Order.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

end
