class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :banned?, :prepare_for_mobile, :initialized_variables




  ##
  # This method helps initialize a shopping cart for a user that has just logged in
  #
  # Story: can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def initialized_variables
    @cart = current_cart
    if current_user != nil
      line_items = LineItem.where("user_id = ? AND line_item_type = ?", current_user.id, 0)

      line_items.each do |line_item|
        line_item.cart_id = @cart.id
        line_item.save
      end
    end
  end

  ##
  # This action helps to filter those users who are banned from logging to the system
  #
  # Story: can deactivate and reactivate a user of the system(https://www.pivotaltracker.com/story/show/38562115)
  #
  # @param: search
  #
  # @return
  #
  def banned?
    if current_user.present? && !current_user.activated?
      sign_out current_user
      flash[:error] = "This account has been suspended...."
      redirect_to new_user_session_path
    end
  end


  ##
  # This method helps to render the proper layout based on the web agent that is being used
  #
  # Story: Can use the website on mobile(https://www.pivotaltracker.com/story/show/39113015)
  #
  # @param: search
  #
  # @return
  #
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

##
# This method helps to render the proper layout based on the web agent that is being used
#
# Story: Can use the website on mobile(https://www.pivotaltracker.com/story/show/39113015)
#
# @param: search
#
# @return
#
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

  ##
  # This method helps to recover the current shopping cart of a user
  #
  # Story: can buy multiple items with one transaction (shopping cart)(https://www.pivotaltracker.com/story/show/39112899)
  #
  # @param: search
  #
  # @return
  #
  def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
  end


end
