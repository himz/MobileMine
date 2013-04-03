class AdminItemsController < ApplicationController

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
  # This action sets values that are used by the list of items page for admin
  #
  # Story: Admin can see all items of the system (https://www.pivotaltracker.com/story/show/38883293)
  #
  # @param: search
  #
  # @return
  #
  def index
    @items=Item.paginate(:per_page=>10, :page=>params[:page])
    @search = Item.search(params[:search])
  end

  ##
  # This action deletes an item from database  for admin
  #
  # Story: Admin can remove any item of the system (https://www.pivotaltracker.com/story/show/38562123)
  #
  # @param: search, id
  #
  # @return
  #
  def delete
    @item = Item.find_by_id(params[:id])
    if @item.destroy
      redirect_to admin_items_index_path
    end
  end

  ##
  # This action sets values that are used by detail of item page for admin
  #
  # Story: Admin can see information about a specific item (https://www.pivotaltracker.com/story/show/38883423)
  #
  # @param: id, search
  #
  # @return
  #
  def show
    @item=Item.find(params[:id])
    @search = Item.search(params[:search])
  end

  ##
  # This action sets to false the activated value of a given item
  #
  # Story: can deactivate and reactivate any item of the system (https://www.pivotaltracker.com/story/show/38562133)
  #
  # @param: id
  #
  # @return
  #
  def deactivate
    @item = Item.find_by_id(params[:id])
    @item.update_column(:activated,false)
    redirect_to admin_items_index_path
  end

  ##
  # This action sets to false the activated value of a given item
  #
  # Story: can deactivate and reactivate any item of the system (https://www.pivotaltracker.com/story/show/38562133)
  #
  # @param: id
  #
  # @return
  #
  def activate
    @item = Item.find_by_id(params[:id])
    @item.update_column(:activated,true)
    redirect_to admin_items_index_path
  end
end
