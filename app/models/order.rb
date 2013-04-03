class Order < ActiveRecord::Base
  ##
  # The Order model has details of an item including:
  #
  # buyer_id: The user buying the product, Mandatory parameter
  # seller_id: The item seller, Mandatory parameter
  # item_id: Item_id for the product, Mandatory parameter
  # state: Order state =>{processing, transit, shipped, cancelled}, Mandatory parameter.
  # item_quantity: Number of items in the order
  # billing_address: Address of the payment used to purchase the order
  # shipping_address: Address to which the order was shipped
  # price: price of item at the time or ordering
  # total_price: quantity*price of item at the time or ordering
  # transaction_id: Id of the transaction which the order is part of
  #
  # Database Model: https://docs.google.com/document/d/12_X6ZmRD042Sr2peaH7DuS3U_om3o31kn17HePzwFDE/edit
  #
  # Each order belongs to an item
  ##
  belongs_to :item

  attr_accessible :buyer_id, :item_id, :seller_id, :state, :item_quantity,:billing_address,:price,:total_price,:transaction_id ,:shipping_address

  validates :buyer_id, :presence => true, :numericality=> { :only_integer => true}
  validates :seller_id, :presence => true, :numericality=> { :only_integer => true}
  validates :item_id, :presence => true, :numericality=> { :only_integer => true}
  validates :state, :presence => true, :length => { :is => 1 }, :numericality=> { :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 4}
  validates :billing_address, :presence => true
end
