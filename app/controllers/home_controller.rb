# Controller for the home page
class HomeController < ApplicationController
  before_filter :initialize_cart
  def initialize_cart
    #Add a Cart to SideBar
    @cart = current_cart
  end
  ##
  # This action sets values that are used by the home page
  #
  # Story: Display front page(https://www.pivotaltracker.com/projects/644119#!/stories/36203957)
  #
  # @param: search
  #
  # @return
  #
  def index
    @categories = Category.all
    #Get popular times,
    ## TODO: @popular: Add the logic for sorting based on popularity
    @popular = Item.where(:activated => true).sample(4)
    ## TODO: @featured: Select where featured is true, but now we have nothing, so keeping this random
    @featured = Item.where(:activated => true).sample(4)
    @search = Item.search(params[:search])
    @items = @search.where(:activated => true).all   # or @search.relation to lazy load in view
  end
end