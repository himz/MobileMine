class AdminUsersController < ApplicationController

  before_filter :confirm_login_admin

  def confirm_login_admin
    if current_user==nil or current_user.user_type!=0
      redirect_to(:controller => 'home',:action => 'index')
      return false
    else
      return true
    end
  end

  ##
  # This action sets values that are used by the list of users page for admin
  #
  # Story: Admin can see all users of the system (https://www.pivotaltracker.com/story/show/38562093)
  #
  # @param: search
  #
  # @return
  #
  def index
    @users=User.paginate(:per_page=>10, :page=>params[:page])
    @search = Item.search(params[:search])
  end

  ##
  # This action deletes a user from database  for admin
  #
  # Story: Admin can remove any user of the system(https://www.pivotaltracker.com/story/show/38562103)
  #
  # @param: search, id
  #
  # @return
  #
  def delete
    @user = User.find_by_id(params[:id])
    if @user.destroy
      redirect_to admin_users_index_path
    end
  end

  ##
  # This action sets values that are used by detail of user page for admin
  #
  # Story: Admin can see information about a specific user(https://www.pivotaltracker.com/story/show/38882395)
  #
  # @param: id, search
  #
  # @return
  #
  def show
    @user=User.find(params[:id])
    @search = Item.search(params[:search])

     end

  ##
  # This action sets to false the activated value of a given user
  #
  # Story: can deactivate and reactivate a user of the system (https://www.pivotaltracker.com/story/show/38562115)
  #
  # @param: id
  #
  # @return
  #
  def deactivate
    @user = User.find_by_id(params[:id])
    @user.update_column(:activated,false)
    redirect_to admin_users_index_path


  end

  ##
  # This action sets to true the activated value of a given user
  #
  # Story: can deactivate and reactivate a user of the system (https://www.pivotaltracker.com/story/show/38562115)
  #
  # @param: id
  #
  # @return
  #
  def activate
    @user = User.find_by_id(params[:id])
    @user.update_column(:activated,true)
    redirect_to admin_users_index_path


  end
end
