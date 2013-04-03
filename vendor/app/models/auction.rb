class Auction < ActiveRecord::Base
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
  validates :bid_amount, :presence => true
  validates :seller_id, :presence => true, :numericality=> { :only_integer => true}
  validates :end_time, :presence => true
  validates :item_id, :presence => true, :numericality=> { :only_integer => true}
  validates :state, :presence => true, :length => { :is => 1 }, :numericality=> { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 4}


  def close_auction
    self.update_attribute(:state,1)
  end

 handle_asynchronously :close_auction
  #, :run_at => Proc.new { (  @end_time.hour.hours+@auction.end_timen.min.minutes).from_now}
  #TODO: Fix this! Time is not getting set correctly
end
