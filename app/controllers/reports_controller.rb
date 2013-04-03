class ReportsController < ApplicationController
  before_filter :confirm_login ,  :orderStates,:userTypes, :except => [ :track]
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

  def userTypes
    @userTypes = Hash.new
    @userTypes[0] = "Admin"
    @userTypes[1] = "Buyer"
    @userTypes[2] = "Seller"
  end

  def seller_details
    @search = Item.search(params[:search])
    @user_id = current_user.id
    @sql_query_chart ="select first_name , sum(total_price) sum_price, seller_id, temp.id user_id , activated,last_name
    from orders,  ( select first_name , id, activated ,last_name from users ) temp
    where orders.seller_id = temp.id
    group by seller_id order by sum_price desc limit ? "

    @no_of_items=5
    if(params[:no_of_items])
      @no_of_items = params[:no_of_items]
    end
    @data_chart_sellers_price = Order.find_by_sql([@sql_query_chart, @no_of_items])
    #Show all the fields in the table
    @data_sellers_price = Order.find_by_sql([@sql_query_chart, -1])

  end


  def buyer_details
    @search = Item.search(params[:search])
    @user_id = current_user.id
    @no_of_items=5
    if(params[:no_of_items])
      @no_of_items = params[:no_of_items]
    end
    @sql_query_chart ="select first_name , sum(total_price) sum_price, buyer_id,activated,last_name
    from orders,  ( select first_name , id, activated ,last_name from users ) temp
    where orders.buyer_id = temp.id
    group by buyer_id order by sum_price desc limit ? "

    #@buyers_aggregated= Order.find_by_sql(@sql_query_chart, @no_of_items)
    @data_chart_buyers_price = Order.find_by_sql([@sql_query_chart, @no_of_items])
    #Show all the fields in the table
    @data_buyers_price =       Order.find_by_sql([@sql_query_chart, -1])

  end

  def sales_details
    #controller for the data for chart showing sales(as quantity) with products
    #gives the idea of most popular products of the system
    @search = Item.search(params[:search])
    @user_id = current_user.id
    @no_of_items=5
    if(params[:no_of_items])
      @no_of_items = params[:no_of_items]
    end

    @sql_query_chart= "select name , sum(item_quantity) sum_sales , buyer_id,activated, first_name
    from orders,  ( select name , id, activated  from items ) temp,
    ( select first_name , id,last_name from users ) temp_seller
    where orders.item_id = temp.id and
    orders.seller_id = temp_seller.id
    group by item_id order by sum_sales desc limit ? "

    #@buyers_aggregated= Order.find_by_sql(@sql_query_chart, @no_of_items)
    @data_chart_sales_products = Order.find_by_sql([@sql_query_chart, @no_of_items])
    #Show all the fields in the table
    @data_sales_products =       Order.find_by_sql([@sql_query_chart, -1])

  end


  def index
    @search = Item.search(params[:search])
    @user_id = current_user.id
    ## Using individual queried directly here, to optimize index page loading

    #Display Buyer Chart
    @sql_query_chart ="select first_name , sum(total_price) sum_price, buyer_id,activated,last_name
    from orders,  ( select first_name , id, activated ,last_name from users ) temp
    where orders.buyer_id = temp.id
    group by buyer_id limit 7"
    @data_chart_buyers_price= Order.find_by_sql(@sql_query_chart)

    #Display seller chart
    @sql_query_chart ="select first_name , sum(total_price) sum_price, buyer_id,activated,last_name
    from orders,  ( select first_name , id, activated ,last_name from users ) temp
    where orders.seller_id = temp.id
    group by seller_id limit 7"
    @data_chart_sellers_price= Order.find_by_sql(@sql_query_chart)

    #Display Sales Chart
    @sql_query_chart= "select name , sum(item_quantity) sum_sales
    from orders,  ( select name,id from items ) temp
    where orders.item_id = temp.id
    group by item_id order by sum_sales desc limit 5"
    @data_chart_sales_products = Order.find_by_sql(@sql_query_chart)

    #Random Important information
    @total_users =  Order.find_by_sql("select count(id)  total from users")
    @total_sellers =  Order.find_by_sql("select count(id)  total from users where user_type = 2")
    @total_admins =  Order.find_by_sql("select count(id)  total from users where user_type = 0")
    @total_buyers =  Order.find_by_sql("select count(id)  total from users where user_type = 1")
    @total_items =Order.find_by_sql("select count(id)  total from items ")
    @total_categories =Order.find_by_sql("select count(id)  total from item_categories ")
    @total_sales_last_week_price=Order.find_by_sql("select sum(total_price) total from orders where DATE(created_at) >= DATE('now', 'weekday 0', '-7 days')") # By Price
    puts @total_users

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
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

