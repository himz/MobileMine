class CartsController < ApplicationController
  before_filter :metasearch_param

  def metasearch_param
    @search = Item.search(params[:search])
    @categories = Category.all
    @cart = current_cart
  end
  # GET /carts
  # GET /carts.json
  ##
  # This action lists the number of items in the cart  
  #
  # Story: Can Edit a Shopping cart (Sub Task for the Story Card)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
	begin
		@cart = Cart.find(params[:id]) 
		rescue ActiveRecord::RecordNotFound
		logger.error "Attempt to access invalid cart #{params[:id]}"
		redirect_to cart_url, :notice => 'Invalid cart'
	else
		respond_to do |format|
      		format.html # show.html.erb
      		format.xml  { render :xml => @cart }
	end 
     end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  ##
  # This action lets the user edit the cart contents 
  #
  # Story: Can Edit a Shopping cart (Sub Task for the Story Card)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  ##
  # This action creates a new cart and adds an item to the cart
  #
  # Story: can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
	format.js   { @current_item = @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /carts/1
  # PUT /carts/1.json
  ##
  # This action lets the user update the cart
  #
  # Story: can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to(root_path,
	:notice => 'Your cart is currently empty') }
      format.json { head :no_content }
    end
  end
  
  ##
  # This action adds an item to the wishlist
  #
  # Story: Add items to wishlist(https://www.pivotaltracker.com/story/show/37800781)
  #
  # @param: search
  #
  # @return
  #

  def wishlist
    @lineItems = LineItem.where("user_id = ? AND line_item_type = ?", current_user.id, 1)
    @items = Array.new
    @lineItems.each do |lineItem|
      @items.push(lineItem.item)
    end
  end
  
  ##
  # This action lets the user add an item to cart for buying and then checking out for payment
  #
  # Story: Sub Task for -> can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #

  def checkout

    if current_user
      auction_id= params[:id]
      if auction_id
        auction=Auction.find_by_id(auction_id)
        if auction and auction.highest_bidder==current_user.id and auction.state == 1

          LineItem.create(:cart_id=> current_cart.id, :item_id=>auction.item_id,:user_id=>current_user.id,:line_item_type => 9, :auction_id=>auction.id)
        else
          redirect_to :action => 'index', :controller => 'home'
        end
      end

      lineItems = LineItem.find_all_by_user_id(current_user.id)

      @items_string=""
      @price=0
      lineItems.each do |lineItem|
        if(lineItem.line_item_type==0)
          item = Item.find(lineItem.item_id)
          @items_string=@items_string+", "+ item.name+"($" +  item.price+"*" + lineItem.quantity.to_s+")"
          @price= @price+ item.price.to_f   #TODO: ITem price should be float!!!!!
        end
      end
    else
      redirect_to :action => 'index', :controller => 'home'

    end
  end

  ##
  # This action lets the user pay for the items in the cart for payment
  #
  # Story: purchase item by adding to shopping cart (https://www.pivotaltracker.com/story/show/37699829)
  #
  # @param: search
  #
  # @return
  #
  def confirm_checkout
        lineItems = LineItem.find_all_by_user_id(current_user.id)
        if(lineItems)
          @transaction = Transaction.create(:buyer_id => current_user.id)
          user = current_user
          baddress = params[:address]
          bzipcode = params[:zipcode]
          if(!baddress || !bzipcode || baddress.length <=0 || bzipcode.length <=0)
            redirect_to cart_checkout_path, :notice => 'Please enter the address'   #TODO: This notice should appear on page
          elsif (!params[:card][:user_id] || params[:card][:user_id].length<=0)
            redirect_to cart_checkout_path, :notice => 'Please select a credit card for payment'
          else
            if(params[:saddress] && params[:szipcode] && params[:saddress].length>0 && params[:szipcode].length == 5 )
              @saddress = params[:saddress]
              @szipcode = params[:szipcode]
            else
              @saddress= baddress
              @szipcode = bzipcode
            end


          @confirmed_items = ""
          @unavailable_items = ""
          @orders = []
          if @transaction.save
            lineItems.each do |lineItem|
                if(lineItem.line_item_type==9)
                  order = Order.new
                  item = Item.find(lineItem.item_id)
                  auction = Auction.find_by_id(lineItem.auction_id)
                  if(auction.state==1)
                    auction.update_attribute(:state,2)
                    order.billing_address = baddress  + bzipcode
                    order.shipping_address = @saddress  + @szipcode
                    order.item_quantity = lineItem.quantity
                    order.price = Auction.find_by_item_id(lineItem.item_id).bid_amount
                    order.total_price = Auction.find_by_item_id(lineItem.item_id).bid_amount * lineItem.quantity
                    order.transaction_id = @transaction.id
                    order.seller_id = item.user_id
                    order.buyer_id = current_user.id
                    order.item_id = item.id
                    order.state = 0

                    if(!order.save)
                      redirect_to "back", :notice => "Error creating order,  or contact administrator with this message"
                    else
                      @orders.push(order)
                      @confirmed_items = @confirmed_items + " " + item.name+"("+lineItem.quantity.to_s+")"
                      NotifyUser.order_confirmation(user,@confirmed_items,@orders).deliver
                      lineItem.destroy
                    end
                  end

                end


                if(lineItem.line_item_type==0)
                order = Order.new
                item = Item.find(lineItem.item_id)
                if(lineItem.quantity<=item.availability)
                  order.billing_address = baddress  + bzipcode
                  order.shipping_address = @saddress  + @szipcode
                  order.item_quantity = lineItem.quantity
                  order.price = item.price
                  order.total_price = Float(item.price) * lineItem.quantity
                  order.transaction_id = @transaction.id
                  order.seller_id = item.user_id
                  order.buyer_id = current_user.id
                  order.item_id = item.id
                  order.state = 0

                  if(order.save)
                    item.sold_count += lineItem.quantity
                    item.availability -= lineItem.quantity
                    item.save
                    @orders.push(order)
                    @confirmed_items = @confirmed_items + " " + item.name+"("+lineItem.quantity.to_s+")"
                    NotifyUser.order_confirmation(user,@confirmed_items,@orders).deliver
                    lineItem.destroy
                  else
                    redirect_to :back, :notice => "Error creating order, verify your inputs or contact administrator with this message"
                  end
                else
                  @unavailable_items = @unavailable_items + " " + item.name+"("+lineItem.quantity.to_s+")"
                end
              end
            end
          end
          end
          #redirect_to :action => 'index', :controller => 'orders'
          else
          redirect_to :back, :notice => 'Unknown processing error. Please verify your orders' #TODO: Cart screen
          end
        end
    end

