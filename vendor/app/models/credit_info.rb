class CreditInfo < ActiveRecord::Base
  ##
  # The Credit Card Information model  has details of an item including:
  # user_id: The owner of the credit card, Mandatory parameter
  # billing_address: The billing address associated with the credit card, Mandatory parameter
  # credit_card_no: Credit card no. It is unique , Mandatory parameter
  # zipcode: Order state =>{processing, transit, shipped, cancelled}, Mandatory parameter.
  #
  # Database Model: https://docs.google.com/document/d/12_X6ZmRD042Sr2peaH7DuS3U_om3o31kn17HePzwFDE/edit
  #
  # each credit card belongs to a user
  ##

  belongs_to :user
  attr_accessible :billing_address, :credit_card_no, :user_id, :zipcode
  validates :user_id, :presence => true, :numericality=> { :only_integer => true}
  validates :billing_address, :presence => true
  validates :credit_card_no, presence:true, :length => { :is => 16 }
  validates :zipcode, presence:true, :length => { :is => 5 }, :numericality=> { :only_integer => true}
end
