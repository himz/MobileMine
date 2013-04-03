require 'will_paginate/array'
class AuctionsController < ApplicationController
  before_filter :confirm_login
  # See list of items put for auction
  # Story: Can see items put for auction(https://www.pivotaltracker.com/story/show/39145541)
  # @param: search
  #
  # @return
  # ##               @items.each do |item|
  def index
    @auctions = Auction.where(:state => 0)
    @categories = Category.all
    @items = []
    @auctions.each do |auction|
      @items.push(Item.find_by_id(auction.item_id))
    end
    @items = @items.paginate(:per_page=>16, :page=>params[:page])
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auctions }
    end
  end

  # See list of items that were auctioned in the past by a seller
  # Story: Can see dashboard ()https://www.pivotaltracker.com/story/show/37694955 )
  # @param: search
  #
  # @return
  # ##
  def seller_auction_history_index
    @auctions = Auction.where(:seller_id => current_user.id).where("state > 0")


    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auctions }
    end
  end

  # See list of bidded items by a user
  # Story: Can see dashboard ()https://www.pivotaltracker.com/story/show/37694955 )
  # @param: search
  #
  # @return
  # ##
  def user_bids_index

    #@auctions = Auction.where(:state => 0, :highest_bidder => current_user.id)
    #@categories = Category.all
    #@items = []
    #@auctions.each do |auction|
    #  @items.push(Item.find_by_id(auction.item_id))
    #end
    #@items = @items.paginate(:per_page=>16, :page=>params[:page])
    auction_ids=User.find(current_user.id).auctions
    @auctions=[]
    auction_ids.each do |auction_id|
      auction=Auction.find(auction_id)
     if auction and auction.state==0
      @auctions.push(auction)
     end
    end
    #@auctions=@auctions.where(:state=>0)
    @search = Item.search(params[:search])

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
    if(current_user.user_type!=2)
      redirect_to root_path
    else
      @items = Item.where(:user_id => current_user.id, :auction_flag => !true).where("availability > 0")

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
  end

  # See page where user can bid for an item
  # Story: Bid for items(https://www.pivotaltracker.com/story/show/38376169 )
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
      @auction.update_attribute(:bid_amount,@bid)
      @auction.update_attribute(:highest_bidder,current_user.id)
      user=User.find(current_user.id)

      user.update_attribute(:auctions,user.auctions.push(@auction.id))
      user.update_attribute(:auctions,user.auctions.uniq )




      # bid_amount = @bid
      #@auction.highest_bidder = current_user.id
      #@auction.save
    end
  end

  # Seller can change the state of the auction
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, @auction id, state, end_time
  #
  # @return
  # ##
  def change_state
    @auction = Auction.find(params[:id])
    #@auction.state = params[:state].to_i

    if @auction.update_attributes(params[:auction])
      @auction.delay.close_auction(@auction.id)
      redirect_to(:action => 'show', :controller => 'items', :id => @auction.item_id)

    else
      @search = Item.search(params[:search])

      render action: "seller_edit"
     # redirect_to(:action => 'seller_edit', :id => @auction.id)
    end
  end

  # Seller can cancel an auction
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007)
  # @param: search
  #
  # @return
  # ##
  def seller_cancel

    @auction = Auction.find(params[:id])
    @auction.end_time=@auction.end_time.getlocal.strftime("%Y-%m-%d %H:%M")
    @item = Item.find(@auction.item_id)
    @search = Item.search(params[:search])
    #redirect_to(:action => 'show', :id => @auction.item_id)
  end


  # Seller can edit the auction details
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007
  # @param: search, auction id
  #
  # @return
  # ##
  def seller_edit

   @auction = Auction.find(params[:id])
   @auction.end_time=@auction.end_time.getlocal.strftime("%Y-%m-%d %H:%M")
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
    @auction = Auction.new(params[:auction])
    @auction.state=0
    @auction.seller_id = current_user.id
   # @auction.end_time=@auction.end_time.to_datetime

    #Time.now+@auction.end_time.hour*3600+@auction.end_time.min*60



    @search = Item.search(params[:search])
    respond_to do |format|
      if @auction.save
        job=@auction.send_at(@auction.end_time,:close_auction)
        @auction.update_attribute(:job_id,job.id)
        @item = Item.find(@auction.item_id)
        @item.auction_flag = true
        @item.update_attribute(:availability,@item.availability-1)
        @item.auction_id = @auction.id
        @item.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render json: @auction, status: :created, location: @auction }
      else
        @items = Item.where(:user_id => current_user.id, :auction_flag => false).where("availability > 0")
        if(@items && @items.count>0)
          @item_hash = @items.inject({}) {|h,(k,v)| h[k.id.to_s + ":" + k.name]=k.id; h} #Keep a hash to id to name for select drop list to use
        else
          @item_hash= {}
        end
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

  # Seller can delete an auction
  # Story: Auction items(https://www.pivotaltracker.com/story/show/38376007)
  # @param: search
  #
  # @return
  # ##
  def destroy
    @auction = Auction.find(params[:id])

    @search = Item.search(params[:search])
    item_id=@auction.item_id

    if @auction.highest_bidder.nil?
      @item = Item.find(@auction.item_id)
      @item.update_attribute(:availability,@item.availability+1)
      job_id=@auction.job_id
      item=Item.find(item_id)
      item.update_attribute(:auction_flag,false)
      item.update_attribute(:auction_id,nil)
      @auction.destroy
      Delayed::Job.find(job_id).delete

      respond_to do |format|
        format.html { redirect_to item_path(item_id) }
        format.json { head :no_content }
      end
    else


      redirect_to item_path(item_id),:notice  => "You can't cancel this auction because it has a bidder"
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

