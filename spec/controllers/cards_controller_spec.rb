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

describe CardsController do

  let(:card) { FactoryGirl.create(:card) }
  let(:user) { FactoryGirl.create(:user) }
  # This should return the minimal set of attributes required to create a valid
  # Auction. As you add validations to Auction, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
        :card_number => "4000400040004000",
        :cvv => "123",
        :expiry_date => "2012-11-21"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AuctionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  it "has a valid factory" do
    card.should be_valid
  end

  describe "GET index" do
    xit "assigns all cards as @cards" do
      card = Card.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cards).should eq([card])
    end
  end

  describe "GET show" do
    xit "assigns the requested card as @card" do
      card = Card.create! valid_attributes
      get :show, {:id => card.to_param}, valid_session
      assigns(:card).should eq(card)
    end
  end

  describe "GET new" do
    login_user
    it "assigns a new card as @card" do
      get :new, {}, valid_session
      assigns(:card).should be_a_new(Card)
    end
  end

  describe "GET edit" do
    xit "assigns the requested card as @card" do
      card = Card.create! valid_attributes
      get :edit, {:id => card.to_param}, valid_session
      assigns(:card).should eq(card)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      xit "creates a new Card" do
        expect {
          post :create, {:card => valid_attributes}, valid_session
        }.to change(Card, :count).by(1)
      end

      xit "assigns a newly created card as @card" do
        post :create, {:card => valid_attributes}, valid_session
        assigns(:card).should be_a(Card)
        assigns(:card).should be_persisted
      end

      xit "redirects to the created card" do
        post :create, {:card => valid_attributes}, valid_session
        response.should redirect_to(Card.last)
      end
    end

    describe "with invalid params" do
      xit "assigns a newly created but unsaved card as @card" do
        # Trigger the behavior that occurs when invalid params are submitted
        Card.any_instance.stub(:save).and_return(false)
        post :create, {:card => {}}, valid_session
        assigns(:card).should be_a_new(Card)
      end

      xit "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Card.any_instance.stub(:save).and_return(false)
        post :create, {:card => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      xit "updates the requested card" do
        card = Card.create! valid_attributes
        # Assuming there are no other cards in the database, this
        # specifies that the Card created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Card.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => card.to_param, :card => {'these' => 'params'}}, valid_session
      end

      xit "assigns the requested card as @card" do
        card = Card.create! valid_attributes
        put :update, {:id => card.to_param, :card => valid_attributes}, valid_session
        assigns(:card).should eq(card)
      end

      xit "redirects to the card" do
        card = Card.create! valid_attributes
        put :update, {:id => card.to_param, :card => valid_attributes}, valid_session
        response.should redirect_to(card)
      end
    end

    describe "with invalid params" do
      xit "assigns the card as @card" do
        card = Card.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Card.any_instance.stub(:save).and_return(false)
        put :update, {:id => card.to_param, :card => {}}, valid_session
        assigns(:card).should eq(card)
      end

      xit "re-renders the 'edit' template" do
        card = Card.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Card.any_instance.stub(:save).and_return(false)
        put :update, {:id => card.to_param, :card => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    xit "destroys the requested card" do
      card = Card.create! valid_attributes
      expect {
        delete :destroy, {:id => card.to_param}, valid_session
      }.to change(Card, :count).by(-1)
    end

    xit "redirects to the cards list" do
      card = Card.create! valid_attributes
      delete :destroy, {:id => card.to_param}, valid_session
      response.should redirect_to(cards_url)
    end
  end

end
