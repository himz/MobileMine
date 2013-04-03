require 'will_paginate/array'
class AuctionsController < ApplicationController
  before_filter :confirm_login
  # See list of items, can be used by admin. Currently unused. Or make this user specific
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search
  #
  # @return
  # ##
  def index
    @auctions = Auction.where(:state => 0)
    @categories = Category.all
    @items = []
    @auctions.each{|auction|@items.push(Item.find(auction.item_id))}
    @items = @items.paginate(:per_page=>16, :page=>params[:page])
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auctions }
    end
  end

  # Seller can see auction details
  # Story: Bid for items(https://www.pivotaltracker.com/story/show/38376169
  # @param: search, id
  #
  # @return
  # ##
  def show
    @auction = Auction.find(params[:id])
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @auction }
    end
  end

  # Seller can create new auctions
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search
  #
  # @return
  # ##
  def new
    @auction = Auction.new

    @items = Item.find_all_by_user_id(current_user.id)
    if(@items && @items.count>0)
      @item_hash = @items.inject({}) {|h,(k,v)| h[k.id.to_s + ":" + k.name]=k.id; h} #Keep a hash to id to name for select drop list to use
    else
      @item_hash= {}
      end
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auction }
    end
  end

  # Seller can edit the auction details
  # Story: Bid for items(https://www.pivotaltracker.com/story/show/38376169
  # @param: search, bid_amount, auction, bid_amount
  #
  # @return
  # ##
  def increase_bid
    @auction = Auction.find(params[:auction])
    @item = Item.find(@auction.item_id)
    @bid = params[:bid_amount]
    @search = Item.search(params[:search])
    if(@auction.end_time<Time.now)
      @message = "You are too late for this auction. It ended at "+@auction.end_time.to_s
    elsif(@bid.to_f<=@auction.bid_amount)
      then
      @message="You need to bid higher than "+ @auction.bid_amount.to_s
    else
      @message="Congrats! You are the highest bidder now"
      @auction.bid_amount = @bid
      @auction.highest_bidder = current_user.id
      @auction.save
    end
  end

  # Seller can change the state of the auction
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, @auction id, state, end_time
  #
  # @return
  # ##
  def change_state
    @auction = Auction.find(params[:auction])
    @auction.state = params[:state].to_i
    @auction.end_time = params[:end_time]
    @auction.save
    @auction.delay.close_auction(@auction.id)
    redirect_to(:action => 'show', :controller => 'items', :id => @auction.item_id)
  end

  # Seller can edit the auction details
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, auction id
  #
  # @return
  # ##
  def seller_edit
   @auction = Auction.find(params[:id])
   @item = Item.find(@auction.item_id)
   @search = Item.search(params[:search])
   #redirect_to(:action => 'show', :id => @auction.item_id)
 end

  # Buyers can change the bid
  # Story: Bid for items(https://www.pivotaltracker.com/story/show/38376169
  # @param: search, @auction id
  #
  # @return
  # ##
  def edit
    @auction = Auction.find(params[:id])
    @item = Item.find(@auction.item_id)
    @search = Item.search(params[:search])
  end

  # Sellers can create new auctions
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, auction id
  #
  # @return
  # ##
  def create
    #TODO: Since you are auctioning it off, 1 item goes away from availability count
    @auction = Auction.new(params[:auction])
    @auction.state=0
    @auction.seller_id = current_user.id
    @auction.save
    @auction.send_at(Time.now+@auction.end_time.hour*3600+@auction.end_time.min*60,:close_auction)

    @item = Item.find(@auction.item_id)
    @item.auction_flag = true
    @item.auction_id = @auction.id


    @search = Item.search(params[:search])
    respond_to do |format|
      if @item.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render json: @auction, status: :created, location: @auction }
      else
        format.html { render action: "new" }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # The seller can update auction details using this
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, auction id
  #
  # @return
  # ##
  def update
    @auction = Auction.find(params[:id])
    @search = Item.search(params[:search])
    respond_to do |format|
      if @auction.update_attributes(params[:auction])
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # This is used to delete an auction
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, auction id
  #
  # @return
  # ##
  def destroy
    @auction = Auction.find(params[:id])
    @search = Item.search(params[:search])
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to auctions_url }
      format.json { head :no_content }
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
