class OrdersController < ApplicationController
  before_filter :confirm_login
  ##
  # This action sets values that are used by order confirmation page
  #
  # Story: Display all orders for the user(https://www.pivotaltracker.com/story/show/38555579)
  # @param: search
  #
  # @return
  #
  def index
    @orders = Order.find_all_by_buyer_id(current_user.id)
    @search = Item.search(params[:search])
    @states = Hash.new
    @states[0] = "Processing"
    @states[1] = "Shipped"
    @states[2] = "Delivered"
    @states[3] = "Cancelled"
    respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @orders }
    end
  end

  ##
  # This action sets values that are used by thank you screen to confirm placed order
  #
  # Story: Order Thankyou screen(https://www.pivotaltracker.com/story/show/36285675)
  #
  # @param: id, search
  #
  # @return
  #
  def show
    @order = Order.find(params[:id])
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  def track
    @search = Item.search(params[:search])
    track_id=params[:track_id].to_i
    if (!track_id) then track_id=0 end
    track_id=track_id - 579726 #Random no to make it look nice

    @order = Order.find(track_id) if Order.exists?(track_id)

    if(@order)
      redirect_to @order
    #else
     # redirect_to root_path   #Show error page
    end
  end

  ##
  # This action sets values that are used by confirmation page .
  #
  # Story: Add new Credit Card https://www.pivotaltracker.com/story/show/38554953
  # Story card not yet implemented
  # @param: search
  #
  # @return
  #
  def new
    @item_id = params[:item]
    @credit_cards = CreditInfo.find_by_user_id(current_user.id)
    @categories = Category.all
    @item = Item.find(@item_id)
    @order = Order.new
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  ##
  # This action sets values that are used to edit order.
  #
  # @TODO : TO implement in future
  #  Story Card :https://www.pivotaltracker.com/story/show/36285319
  # @param: search, id
  #
  # @return
  def edit
    @order = Order.find(params[:id])
    @search = Item.search(params[:search])
  end


  ##
  # This action sets values that are used by create new order
  #
  # Story: New Order() https://www.pivotaltracker.com/story/show/36285675)
  # @param: search
  #
  # @return
  def create
   @user_id = current_user.id
   @credit_card_from_form = CreditInfo.find_by_credit_card_no(params[:credit_card_no])
    if(@credit_card_from_form.nil?)
    then
      @credit_info = CreditInfo.new(:user_id=>@user_id,:credit_card_no=>params[:credit_card_no], :billing_address =>params[:address], :zipcode=>params[:zipcode])
      @credit_info.save
    end
    @item = Item.find(params[:item])
    @order = Order.new(:buyer_id=>current_user.id, :seller_id=>@item.user_id, :item_id=>params[:item], :state=>0)
    #state 0 is an unprocessed order, all orders are created in this state
    @item.sold_count = @item.sold_count+1
    #@item.availability = @item.availability - 1 TODO: Fix availability
    @item.save
    @search = Item.search(params[:search])

    respond_to do |format|
    if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.mobile { redirect_to @order, notice: 'Order was successfully created.' }

        format.json { render json: @order, status: :created, location: @order }
    else
       format.html { render action: "new", notice: 'Unknown error is processing'  }
       format.mobile { render action: "new", notice: 'Unknown error is processing'  }

       flash[:notice] = "Unknown error in processing.. " + "buyer" + @order.buyer_id.to_s + "item id" +  @order.item_id.to_s + "order state" + @order.state.to_s
       format.json { render json: @order.errors, status: :unprocessable_entity }
    end
    end
  end

  ##
  # This action sets values that are used by order edit page
  #
  # @TODO TO be implemented correctly in future
  # https://www.pivotaltracker.com/story/show/36285319
  # @param: search, id
  #
  # @return
  #
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm_login
    if !user_signed_in?
      redirect_to(:controller => 'home',:action => 'index')
      return false
    else
      return true
    end
  end
end
