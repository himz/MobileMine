# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  after_filter :send_confirmation, :only => [:create]
	
  def send_confirmation 
	#@user = User.find(current_user.id)	
	NotifyUser.registration_confirmation(@user).deliver
  end


  # This action sets values that are used by the user sign up page
  #
  # Story: Signup users(https://www.pivotaltracker.com/story/show/37800717)
  #
  # @param: search
  #
  # @return
  # ##
  def new
    @search = Item.search(params[:search])
    @categories = Category.all
    super
  end

  # This action stores the user information retrieved from the sign up page and stores it in the database
  #
  # Story: Signup users(https://www.pivotaltracker.com/story/show/37800717)
  #
  # @param: search
  #
  # @return
  # ##
  def create
    @search = Item.search(params[:search])
    @categories = Category.all
    super
  end

  ##
  # This action sets values that are used by the edit user information page
  #
  # This will be used in a future story card
  #
  # @param: search, id
  #
  # @return
  #
  def edit
    @search = Item.search(params[:search])
    @categories = Category.all
     super
  end


  def update_without_passwords(params={})
    params.delete(:current_password)
    super(params)
  end
    ##
  # This action sets values of a user and updates the database
  #
  # This will be used in a future story card
  #
  # @param: id, user
  #
  # @return
  #


  def update
    @search = Item.search(params[:search])
    @user = User.find(current_user.id)
    email_changed = @user.email != params[:user][:email]
    password_changed = !params[:user][:password].empty?

   successfully_updated = if email_changed or password_changed   #
                            @user.update_with_password(params[:user])
                          else
                            @userparams = params[:user]
                            @userparams.delete(:current_password)
                            @userparams.delete(:password)
                            @user.update_without_password(@userparams)
                          end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end



  ##
  # This action deletes a user from database
  #
  # This will be used in a future story card
  #
  # @param: id
  #
  # @return
  #
  def destroy
    super
  end

  ##
  # This action sets values that are used by the user profile page
  #
  # This will be used in a future story card
  #
  # @param: search
  #
  # @return
  #
  def profile
    @search = Item.search(params[:search])
    @categories = Category.all
  end

  def activate_seller
    @search = Item.search(params[:search])

    #redirect_to confirm_activate_seller_path

  end

  def confirm_activate_seller
    @search = Item.search(params[:search])
    @user = User.find_by_id(current_user.id)
    @user.update_column(:user_type,2) #Change the user type to seller+Buyer
  end



  ##
  # This action sets values that are used by the show user information page
  #
  # This will be used in a future story card
  #
  # @param: search
  #
  # @return
  #
  def show
    @search = Item.search(params[:search])
    @categories = Category.all
  end
end
