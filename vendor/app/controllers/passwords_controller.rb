# app/controllers/registrations_controller.rb
class PasswordsController < Devise::PasswordsController

  # This action sets values that are used by forgot your password page
  #
  # This will be used in a future story card
  #
  # @param: search
  #
  # @return
  # ##
  def new
    @search = Item.search(params[:search])
    super
  end

  # This action stores the email information retrieved from the forgot your password page and stores it in the database
  #
  # This will be used in a future story card
  #
  # @param: search
  #
  # @return
  # ##
  def create
    @search = Item.search(params[:search])
    super
  end
  def edit 
   @search = Item.search(params[:search])
   super
  end

end
