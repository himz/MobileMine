class AdminCategoriesController < ApplicationController

  before_filter :confirm_login_admin
  ##
  # This action sets values that are used by the list of items page
  #
  # Story: Display list of items(https://www.pivotaltracker.com/story/show/36204003)
  #
  # @param: search
  #
  # @return
  #

  def confirm_login_admin
    if current_user==nil or current_user.user_type!=0
      redirect_to(:controller => 'home',:action => 'index')
      return false
    else
      return true
    end
  end

  ##
  # This action retrieve categories information from the database
  #
  # Story: Admin can see the list of categories (https://www.pivotaltracker.com/story/show/38765275)
  #
  # @param: search, id
  #
  # @return
  #
  def index
    @search = Item.search(params[:search])
    @categories = Category.all
  end

  ##
  # This action delete a category information from the database
  #
  # Story: Admin can delete the list of categories (https://www.pivotaltracker.com/story/show/38765275)
  #
  # @param: search, id
  #
  # @return
  #
  def delete
    @category = Category.find_by_id(params[:id])
    if @category.destroy
      redirect_to admin_category_index_path
    end
  end

  ##
  # This action retrieve a category information from the database
  #
  # Story: Admin can see the detail of the category (https://www.pivotaltracker.com/story/show/38765275)
  #
  # @param: search, id
  #
  # @return
  #
  def show
    @category=Category.find(params[:id])
    @search = Item.search(params[:search])
  end

end
