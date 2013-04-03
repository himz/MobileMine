# Controller for categories
class CategoriesController < ApplicationController
  ##
  # The method index sets values that are used by the category page
  #
  # Story: -
  #
  # @param: search
  #
  # @return
  #
  def index
    @categories = Category.all
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  ##
  # The method show sets values that are used to display items in a particular category
  #
  # Story: Users can select category page('https://www.pivotaltracker.com/story/show/36204027')
  #
  # @param: search, id
  #
  # @return
  #
  def show
    @category = Category.find(params[:id])
    #@products = Product.paginate(:per_page => 10, :page => params[:page])
    @categories = Category.all
    @items=@category.items.where(:activated => true)

    @items = @items.paginate(:per_page=>16, :page=>params[:page]) #@category.items
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  ##
  # The method show sets values that are used for new category page
  #
  # Story: -
  #
  # @param: search
  #
  # @return
  #
  def new
    @category = Category.new
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  ##
  # The method edit sets values that are used for edit category page
  #
  # Story: -
  #
  # @param: search, id
  #
  # @return
  #
  def edit
    @search = Item.search(params[:search])
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  ##
  # The method create saves a new category into the database
  #
  # Story: -
  #
  # @param: search, category
  #
  # @return
  #
  def create
    @category = Category.new(params[:category])
    @search = Item.search(params[:search])
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  ##
  # The method update the information of a category
  #
  # Story: -
  #
  # @param: id, category
  #
  # @return
  #
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  ##
  # The method delete the category from database
  #
  # Story: -
  #
  # @param: id
  #
  # @return
  #
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
