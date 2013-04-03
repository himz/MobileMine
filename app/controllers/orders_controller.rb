class OrdersController < ApplicationController
  before_filter :confirm_login , :initial_filter, :orderStates, :except => [ :track]
  def initial_filter
    @cart = current_cart
  end
  ##
  # This action sets values that are used by order confirmation page
  #
  # Story: Display all orders for the user(https://www.pivotaltracker.com/story/show/38555579)
  # @param: search
  #
  # @return
  #

  def orderStates
    @states = Hash.new
    @states[0] = "Processing"
    @states[1] = "Shipped"
    @states[2] = "Delivered"
    @states[3] = "Cancelled"
  end

  def index
    @orders = Order.where("buyer_id = ? AND (state = 0 OR state = 1)", current_user.id);
    @search = Item.search(params[:search])
    respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @orders }
    end
  end


  def history_orders
    @orders = Order.where("buyer_id = ? AND (state = 2 OR state = 3)", current_user.id);
    @search = Item.search(params[:search])
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


  def process_order
    #TODO: Add validations with user id
    @order = Order.find(params[:id])
    @state = params[:state]
    @order.state= @state
    if(@state.to_i==3)
      @item = Item.find(@order.item_id)
      @item.availability += 1
      @item.save
    end
    #TODO: CAncelled item goes back to inventory
    @order.save
    @search = Item.search(params[:search])
    redirect_to @order
  end
=begin
  ## Function to translate the numerical value of states to strings
  # Meaning of states :
  # 0= processing
  # 1= shipping
  # 2= shipped
  # 3= cancelled
  def order_state
    @order = Order.find(params[:id])
    @order_state = "Processing"
    case @order.state
      when 0
        @order_state = "Processing"
      when 1
        @order_state = "Shipping"
      when 2
        @order_state = "Shipped"
      when 3
        @order_state = "Cancelled"
    end
    return @order_state
  end
=end

  def seller_history
    @search = Item.search(params[:search])
    @user_id = current_user.id
    @orders = Order.find_all_by_seller_id(@user_id)
    @aggregate =0
    @no_of_items =5
    @state_report=4
    if(params[:no_of_items])
      @no_of_items = params[:no_of_items]
    end
    if(params[:state_report])
      @state_report = params[:state_report].to_i
    end
    puts @state_report
    if(@state_report <4)
      puts "*******************************"
      @sql_query_table ="select * from orders where seller_id = ? and state = ? group by item_id"
      @sql_query_table_no_aggregation ="select * from orders where seller_id = ? and state = ? "
      @sql_query_chart ="select item_id, created_at, SUM(item_quantity) sum_items from orders where seller_id = ? and state = ? group by item_id order by sum_items desc limit ? "
    else
      puts "-------------------------------------"
      @sql_query_table_no_aggregation ="select * from orders where seller_id = ? and state < ? "
      @sql_query_table ="select * from orders where seller_id = ? and state < ? group by item_id"
      @sql_query_chart ="select item_id, created_at, SUM(item_quantity) sum_items from orders where seller_id = ? and state < ? group by item_id order by sum_items desc limit ? "
    end




    if(params[:random] && params[:random].to_i == 1)
      #TODO: put logic for aggregated
      @aggregate=1
      @orders = Order.find_by_sql([@sql_query_table ,@user_id, @state_report])
    else
      @aggregate=0
      @orders = Order.find_by_sql([@sql_query_table_no_aggregation ,@user_id, @state_report])
      #@orders = Order.find_all_by_seller_id(@user_id)
    end
    #For chart
    @orders_aggregated= Order.find_by_sql([@sql_query_chart, @user_id, @state_report, @no_of_items])

  end

  def seller_current
    @search = Item.search(params[:search])
    @user_id = current_user.id


    if(params[:random] && params[:random].to_i == 1)
      #TODO: put logic for aggregated
      @aggregate=1
      @orders = Order.find_by_sql(["select * from orders where seller_id = ? and state = 0 group by item_id ",@user_id])
    else
      @aggregate=0
      @orders = Order.find_all_by_seller_id_and_state(@user_id,0)
    end
    @orders_aggregated= Order.find_by_sql(["select item_id, created_at, SUM(item_quantity) sum_items  from orders where seller_id = ? and state = 0 group by item_id order by sum_items ",@user_id])
  end

  ##
  # This action sets values that are used by create new order

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

