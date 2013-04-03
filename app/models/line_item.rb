class LineItem < ActiveRecord::Base
  ##
  # The LineItem model has:
  # item_id : mandatory parameter
  # cart: which cart it belongs to
  # total_price: current price * quantity
  # line_item_type: whether item is bought for purchase or added to wishlist
  # auction_id: Reference if the item is an auction
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  # Each lineItem belongs to an item, user and cart
  ##
  belongs_to :item
  belongs_to :cart
  belongs_to :user
  attr_accessible :item, :cart, :item_id, :cart_id, :total_price,:user_id, :quantity, :line_item_type, :auction_id

  validates :item_id, :presence => true, :uniqueness => true

  ##
  #Helper function to calculate total price
  def total_price
    if self.line_item_type==9
      Integer(Auction.find_by_id(auction_id).bid_amount) * quantity
    else
      Integer(item.price) * quantity
    end
  end
end
