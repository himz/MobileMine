class NotifyUser < ActionMailer::Base
	default :from => "cmugivemea@gmail.com"

  ##
  # Sends an email to the user upon registration
  #
  # @param: user
  #
  # @return
  #

	def registration_confirmation(user)
		@user = user
		mail(:to => user.email, :subject => "Registration")
  end

  ##
  # Sends an email to the user with list of items when an order is created
  #
  # @param: user, confirmed_items,orders)
  #
  # @return
  #

  def order_confirmation(user,confirmed_items,orders)
		@user = user
		@confirmed_items  = confirmed_items
		@orders = orders
		mail(:to => user.email, :subject => "Order Confirmation")
  end

  ##
  # Sends an email to the user who won the auction
  #
  # @param: user
  #
  # @return
  #

  def auction_confirmation(auction)
    @auction = Auction.find(auction)
    @user = User.find(auction.highest_bidder)
    mail(:to => @user.email, :subject => "Auction Confirmation")
  end
end
