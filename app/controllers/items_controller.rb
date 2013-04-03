require 'will_paginate/array'
class ItemsController < ApplicationController
 before_filter :confirm_login, :only => [:new_item,:user_item_list, :user_delete_item, :update, :create, :user_edit_item]
 before_filter :initialize_cart
 def initialize_cart
   #Add a Cart to SideBar
   @cart = current_cart
 end
  ##
  # This action sets values that are used by the list of items page
  #
  # Story: Display list of items(https://www.pivotaltracker.com/story/show/36204003)
  #
  # @param: search
  #
  # @return
  #
  def index
    @items=Item.where(:activated => true) #TODO: Add availability
    @categories = Category.all
    @search = Item.search(params[:search])
    @keyword =  params[:search]
    @items = @search.where(:activated => true)   # or @search.relation to lazy load in view
    @items = @items.paginate(:per_page=>16, :page=>params[:page]) #@category.items
  end


  ##
  # This action sets values that are used by new items page
  #
  # Story: Display new products(https://www.pivotaltracker.com/story/show/36285829)
  #
  # @param: search
  #
  # @return
  #
  def new_items_list
    @items = Item.where(:activated => true).sort{ |b,a| a.created_at <=> b.created_at }  #TODO: Add availability
    @items = @items.first(16)
    #TODO: Once we have populated more data, maybe show 12 items instead of four
    @categories = Category.all
    @search = Item.search(params[:search])
    @keyword =  params[:search]
  end

  ##
  # This action delete an item from database
  #
  # Story: Display new products(https://www.pivotaltracker.com/story/show/38541703)
  #
  # @param: search, item_id
  #
  # @return
  #
  def user_delete_item
    @item = Item.find_by_id(params[:id])
    if @item.auction_flag
      #@auction = Auction.find(@item.auction_id)
      #@auction.destroy
      redirect_to item_path(@item),:notice  => "You can't delete this item, because its auctioned and it has a bidder"

    else
      @item.destroy
      redirect_to(:action => 'user_items_list')
    end

  end
  ##
  # This action retrieve item value from database
  #
  # Story: Display new products(https://www.pivotaltracker.com/story/show/37699963)
  #
  # @param: item_id
  #
  # @return
  #
  def user_edit_item
    @item = Item.find_by_id(params[:id])
    @disable_auction_flag = true
    @categories = Category.all
    @item_categories =  ItemCategory.find_all_by_item_id(@item.id)
    @category_ids = @item_categories.collect{|c| c.category_id}
    if(!@category_ids) then @category_ids=[] end
    @search = Item.search(params[:search])
    @keyword =  params[:search]
  end

  ##
  # This action retrieves all the items belonged to the user
  #
  # Story: Display new products(https://www.pivotaltracker.com/story/show/37700031)
  #
  # @param: search
  #
  # @return
  #
  def user_items_list
    @items = Item.find_all_by_user_id(current_user.id)
    @categories = Category.all
    @search = Item.search(params[:search])
    @keyword =  params[:search]
  end

  ##
  # This action create the item adding form for users
  #
  # Story: Display new products(https://www.pivotaltracker.com/story/show/37699873)
  #
  # @param: search
  #
  # @return
  #
  def new_item
    @item=Item.new
    @categories = Category.all

    if(!@category_ids) then @category_ids=[] end
    @search = Item.search(params[:search])
    @keyword =  params[:search]
  end

  ##
  # This action sets values that are used by detail of item page
  #
  # Story: Display detail of item(https://www.pivotaltracker.com/story/show/36285515)
  #
  # @param: id, search
  #
  # @return
  #
  def show
    @item=Item.find(params[:id])
    @search = Item.search(params[:search])
    @keyword =  params[:search]
    if @item.nil? or @item.activated==false
      redirect_to(:controller => 'home',:action => 'index')
    else
      @categories=Category.all
    end

  end





  ##
  # This action retrieves the item information from new item for a seller page and stores it in the database
  #
  # This will be used in a future story card
  #
  # @param: item, search
  #
  # @return
  #

  def create
    @item = Item.new(params[:item])
    @message = @item.validate();
    if(@message)
       redirect_to(user_items_new_path,:notice => @message)
    else
      @search = Item.search(params[:search])
      @categories = Category.all
      @mycategories = params[:category]
      if(!@mycategories) then @mycategories = [] end
      int_array = @mycategories.collect{|s| s.to_i}
      puts "___________________________________________"
      puts @item
        if @item.save
          @categories.each do|category|
            if(int_array.include?(category.id))
            then
              ItemCategory.create(:category_id=>category.id, :item_id=>@item.id)
            end
          end
          if(@item.auction_flag==true)
            @auction = Auction.create(:bid_amount=>@item.price, :item_id=>@item.id, :seller_id=>current_user.id, :state=>0, :end_time=> Time.now+ 1000)
            #TODO: Do not hard code end time
            @item.auction_id = @auction.id
            if !@item.save
            end
          end
          redirect_to(:action => 'show', :id => @item.id)
        else
          render action: "new_item"
        end
      end
  end


  ##
  # This action sets values of item and updates the database
  #
  # This will be used in a future story card
  #
  # @param: id, item
  #
  # @return
  #
  def update
    @item = Item.find(params[:id])
    int_array = params[:category].collect{|s| s.to_i}
    #REset categories
    #delete current
    @itemcats = ItemCategory.find_all_by_item_id(@item.id)
    @itemcats.each{|itemcat|itemcat.destroy}
    #add new
    #Insert and delete is less expensive than each check probably..TODO: Check
    @categories = Category.all
    @categories.each do|category|
      if(int_array.include?(category.id))
      then
          ItemCategory.create(:category_id=>category.id, :item_id=>@item.id)
      end
    end
    if @item.update_attributes(params[:item])
      redirect_to(:action => 'show', :id => @item.id)
    else
      redirect_to(:action => 'user_edit_item', :id => @item.id)
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

