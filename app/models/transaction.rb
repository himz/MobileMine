class Transaction < ActiveRecord::Base
  ##
  # Buyers have a transaction with multiple orders
  #
  attr_accessible :buyer_id
end
