class CardsController < ApplicationController
 before_filter :metasearch_param

  def metasearch_param
    @search = Item.search(params[:search])
    @categories = Category.all
    @cart = current_cart
  end

  ##
   # This action sets values of the credit cards that are registered by the user
   #
   # Story: Can manage credit card information (https://www.pivotaltracker.com/story/show/38554919)
   #
   # @param: search
   #
   # @return
   #
  # GET /cards
  # GET /cards.json
  def index
    @user = User.find(current_user.id)
    @cards = @user.cards
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  ##
   # This action sets values of the credit cards that are registered by the user
   #
   # Story: Credit card numbers should be encrypted (https://www.pivotaltracker.com/story/show/38304049)
   #
   # @param: search
   #
   # @return
   #
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

   # This action sets values of the credit cards that are registered by the user
   #
   # Story:  can enter credit cards (https://www.pivotaltracker.com/story/show/38375851)
   #
   # @param: search
   #
   # @return
   #
  # POST /cards
  # POST /cards.json
  def create
    @user = User.find(current_user.id)
    @card = @user.cards.create(params[:card])

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :no_content }
    end
  end
end
