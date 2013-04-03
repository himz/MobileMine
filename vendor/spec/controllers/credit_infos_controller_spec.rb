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

#TODO: Ignoring these tests until we implement the credit card controls
describe CreditInfosController do
  let(:user) { FactoryGirl.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # CreditInfo. As you add validations to CreditInfo, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
    :user_id=> 1 ,
    :credit_card_no =>"1234567812345678",
    :billing_address =>"MyText"          ,
    :zipcode =>12345
    }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    xit "assigns all credit_infos as @credit_infos" do
      credit_info = CreditInfo.create! valid_attributes
      get :index, {}, valid_session
      assigns(:credit_infos).should eq([credit_info])
    end
  end

  describe "GET show" do
    xit "assigns the requested credit_info as @credit_info" do
      credit_info = CreditInfo.create! valid_attributes
      get :show, {:id => credit_info.to_param}, valid_session
      assigns(:credit_info).should eq(credit_info)
    end
  end

  describe "GET new" do
    xit "assigns a new credit_info as @credit_info" do
      get :new, {}, valid_session
      assigns(:credit_info).should be_a_new(CreditInfo)
    end
  end

  describe "GET edit" do
    xit "assigns the requested credit_info as @credit_info" do
      credit_info = CreditInfo.create! valid_attributes
      get :edit, {:id => credit_info.to_param}, valid_session
      assigns(:credit_info).should eq(credit_info)
    end
  end

  describe "#create" do
    it {should respond_to(:create)}

    it "should call create on Item when POST create is called" do
      credit_info = mock_model(CreditInfo, :attributes= => true, :save => true)
      CreditInfo.stub(:new) { credit_info }
      post :create,  :credit_info => {}
      #response.should redirect_to()
    end

    describe "with valid params" do
      xit "creates a new CreditInfo" do
        expect {
          post :create, {:credit_info => valid_attributes}, valid_session
        }.to change(CreditInfo, :count).by(1)
      end

      xit "assigns a newly created credit_info as @credit_info" do
        post :create, {:credit_info => valid_attributes}, valid_session
        assigns(:credit_info).should be_a(CreditInfo)
        assigns(:credit_info).should be_persisted
      end

      xit "redirects to the created credit_info" do
        post :create, {:credit_info => valid_attributes}, valid_session
        response.should redirect_to(CreditInfo.last)
      end
    end

    describe "with invalid params" do
      xit "assigns a newly created but unsaved credit_info as @credit_info" do
        # Trigger the behavior that occurs when invalid params are submitted
        CreditInfo.any_instance.stub(:save).and_return(false)
        post :create, {:credit_info => {}}, valid_session
        assigns(:credit_info).should be_a_new(CreditInfo)
      end

      xit "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CreditInfo.any_instance.stub(:save).and_return(false)
        post :create, {:credit_info => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      xit "updates the requested credit_info" do
        credit_info = CreditInfo.create! valid_attributes
        # Assuming there are no other credit_infos in the database, this
        # specifies that the CreditInfo created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        CreditInfo.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => credit_info.to_param, :credit_info => {'these' => 'params'}}, valid_session
      end

      xit "assigns the requested credit_info as @credit_info" do
        credit_info = CreditInfo.create! valid_attributes
        put :update, {:id => credit_info.to_param, :credit_info => valid_attributes}, valid_session
        assigns(:credit_info).should eq(credit_info)
      end

      xit "redirects to the credit_info" do
        credit_info = CreditInfo.create! valid_attributes
        put :update, {:id => credit_info.to_param, :credit_info => valid_attributes}, valid_session
        response.should redirect_to(credit_info)
      end
    end

    describe "with invalid params" do
      xit "assigns the credit_info as @credit_info" do
        credit_info = CreditInfo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CreditInfo.any_instance.stub(:save).and_return(false)
        put :update, {:id => credit_info.to_param, :credit_info => {}}, valid_session
        assigns(:credit_info).should eq(credit_info)
      end

      xit "re-renders the 'edit' template" do
        credit_info = CreditInfo.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        CreditInfo.any_instance.stub(:save).and_return(false)
        put :update, {:id => credit_info.to_param, :credit_info => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    xit "destroys the requested credit_info" do
      credit_info = CreditInfo.create! valid_attributes
      expect {
        delete :destroy, {:id => credit_info.to_param}, valid_session
      }.to change(CreditInfo, :count).by(-1)
    end

    xit "redirects to the credit_infos list" do
      credit_info = CreditInfo.create! valid_attributes
      delete :destroy, {:id => credit_info.to_param}, valid_session
      response.should redirect_to(credit_infos_url)
    end
  end

end
