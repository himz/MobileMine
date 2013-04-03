

class Auction < ActiveRecord::Base
  include ActiveModel::Validations
  ##
  # The Auction  model has:
  # bid_amount: The current bid amount
  # highest_bidder: There is one highest bidder (user_id)
  # item_id: The id of the item being auctioned
  # seller_id: The id of the seller
  # state: State of the auction currently "0-Open", "1-Closed", "2-Cancelled", "3-Processing"
  # end_time: The time when auction will close
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  ##
  attr_accessible :bid_amount, :highest_bidder, :item_id, :seller_id, :state, :end_time

  #This will be called by delayed jobs when end time is reached.
  #Schedule the job for 60 seconds prior to when you need it run.
  #Pass in the exact time you need the job executed, as a parameter.
  #Then, run sleep until Time.now == exact_time_down_to_the_second
  validates :bid_amount, :presence => true, :numericality=>true
  validates :seller_id, :presence => true, :numericality=> { :only_integer => true}
  validates :item_id, :presence => true, :numericality=> { :only_integer => true}, uniqueness: true, :unless => :skip_validation
  validates :state, :presence => true, :length => { :is => 1 }, :numericality=> { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 4}
  validates :end_time, :presence => true
  #validates_with DateValidator,  :if => (:dates?)
  validate :end_date_cannot_be_lower  ,  :if => (:dates?)
  validate :availability

  ##
  # Checks if an item is available
  #
  def availability
    if Item.find(item_id).availability<1
      errors.add(:item," has no availability")
    end
  end

  ##
  # Allows skipping item validation
  #
  def skip_validation
    !Item.find(self.item_id).auction_flag
  end

  ##
  # utility functions for date verification
  def dates?
    !self.end_time.nil?
  end

  def end_date_cannot_be_lower
    if end_time < Time.now
      errors.add(:end_time, "can't be lower than current time and date")
    end
  end

  ##
  # Delay the close auction job until auction end time
  def close_auction
    item=Item.find(self.item_id)
    if self.highest_bidder!=nil
      #send a mail to user, create order, etc
      NotifyUser.auction_confirmation(self).deliver
    else
      item.update_attribute(:availability,item.availability+1)
    end
    item.update_attribute(:auction_flag,false)
    self.update_attribute(:state,1)
  end

 handle_asynchronously :close_auction
  #, :run_at => Proc.new { (  @end_time.hour.hours+@auction.end_timen.min.minutes).from_now}
end
