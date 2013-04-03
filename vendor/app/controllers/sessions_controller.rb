# app/controllers/registrations_controller.rb
class SessionsController < Devise::SessionsController




    # This action sets values that are used by the user sign in page
  #
  # Story: User sign in page (https://www.pivotaltracker.com/story/show/37800733)
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

  # This action stores the user information retrieved from the sign in page and stores it in the database.
  # It creates a new session for the corresponding user
  #
  # Story: Session handling for users(https://www.pivotaltracker.com/story/show/38375421)
  #
  # @param: search
  #
  # @return
  # ##
  def create
    @search = Item.search(params[:search])


  super

  end

  #def update
  #  super
  #end

  ##
  # This action deletes the session for a user from database
  #
  # Story: Session handling for users(https://www.pivotaltracker.com/story/show/38375421)
  #
  # @param: id
  #
  # @return
  #
  def destroy

   super


  end


  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user and  authorized_user.activated?
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end
end