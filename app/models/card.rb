class Card < ActiveRecord::Base
  ##
  # The card model has details of an credit card including:
  #
  # which user the card belongs to
  # card_number: 16 digit card number
  # cvv: security code
  # expiry_date: card expiry date
  # user_id: foreign key to user table
  # type: type of card- visa/master card
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  # Each card belongs to a user
  ##

  belongs_to :user
  attr_accessible :card_number, :cvv, :expiry_date, :user_id, :type
  validates :card_number, length: {minimum:16, maximum:16}
  validates :cvv, length: {minimum:3, maximum:4}
  validate :expiry_date_cannot_be_lower
  validates :user_id, :presence => true, :numericality => { :only_integer => true }
  encrypt_with_public_key :card_number,
    :key_pair => Rails.root.join('config','keypair.pem')


     def expiry_date_cannot_be_lower
       if expiry_date < Date.today 
         errors.add(:expiry_date, "can't be lower than  date")
       end
     end
   
  end
