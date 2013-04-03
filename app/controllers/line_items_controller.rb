class LineItemsController < ApplicationController
  before_filter :metasearch_param

  def metasearch_param
    @search = Item.search(params[:search])
    @cart = current_cart
  end
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end


  ##
  # This action is used to move items to the wishlist and the shopping cart
  #
  # Story: Add items to wishlist (https://www.pivotaltracker.com/story/show/37800781)
  #        can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search, item, type
  #
  # @return
  #
  def change_type
    #TODO: Add check fr save success
    @old_line_item = LineItem.find(params[:item])
    if(params[:type].to_i == 1)
      @line_item = LineItem.where(:item_id => @old_line_item.item_id,:user_id=>current_user.id,:line_item_type => params[:type]).first
      if(@line_item)
        redirect_to request.referer, notice: 'Requested item is already in your wishlist. Cancel it to remove from cart'
      else
        @line_item = LineItem.new(:item_id=>@old_line_item.item_id,:user_id=>current_user.id,:line_item_type => params[:type])
        @line_item.save
        @old_line_item.destroy
        redirect_to request.referer, notice: 'Requested item has been moved to your wishlist.'
      end
    else
      @line_item = @cart.add_product(@old_line_item.item_id,current_user.id,params[:type])
      if(@line_item == -1)
        redirect_to request.referer, notice: 'Requested item is currently unavailable. Can not move it to cart.'
      else
        @line_item.save
        @old_line_item.destroy
        redirect_to request.referer, notice: 'Requested item has been added to your cart.'
      end
    end
  end

  ##
  # This action is used to create new items on a shopping cart
  #
  # Story: can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def create
    @cart = current_cart
    item = Item.find(params[:item_id])

    #@line_item = @cart.line_items.build(:item => item)
    if params[:line_item_type] == "0"
      @line_item = @cart.add_product(item.id,current_user.id,params[:line_item_type])
    else
      @line_item = LineItem.where(:item_id => item.id,:user_id=>current_user.id,:line_item_type => params[:line_item_type]).first
      if(@line_item)
        @line_item = -1
      else
        @line_item = LineItem.new(:item_id=>item.id,:user_id=>current_user.id,:line_item_type => params[:line_item_type])
      end
    end

    respond_to do |format|
      if(@line_item == -1)
      then
        if(params[:line_item_type].to_i!=0)
          format.html {
            redirect_to item, notice: 'Requested item is already in your wishlist.'
          }
        else
          format.html {
            redirect_to item, notice: 'Requested item and quantity is currently unavailable.'
          }
        end
      else
        if @line_item.save
          format.html {
            if params[:line_item_type] == "0"
              redirect_to @cart, notice: 'Item was successfully added.'
            else
              redirect_to :controller => 'carts', :action => 'wishlist'
            end
          }
          format.json { render json: @line_item, status: :created, location: @line_item }
        else
          format.html { render action: "new" }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  ##
  # This action is used to delete items from the wishlist or the shopping cart
  #
  # Story: Add items to wishlist (https://www.pivotaltracker.com/story/show/37800781)
  #        can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search, id
  #
  # @return
  #
  def destroy
    @line_item = LineItem.find(params[:id])
    line_item_type = @line_item.line_item_type
    @line_item.destroy

    respond_to do |format|
      format.html {
        if line_item_type == 0
          redirect_to @cart
        else
          redirect_to :controller => 'carts', :action => 'wishlist'
        end
      }
      format.json { head :no_content }
    end
  end
end
