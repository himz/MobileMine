class CreditInfosController < ApplicationController
  before_filter :confirm_login
  ##
  # This action sets values that are used by the Credit Information  page
  #
  # Story: Display all credit cards listed for the user(https://www.pivotaltracker.com/story/show/38554913)
  #
  # @param: search
  #
  # @return
  #
  def index
    @credit_infos = CreditInfo.all
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credit_infos }
    end
  end

  ##
  # This action sets values that are used by show credit info page
  #
  # Story: Display information of the selected credit card(https://www.pivotaltracker.com/story/show/38554913)
  #
  # @param: id, search
  #
  # @return
  #
  def show
    @credit_info = CreditInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credit_info }
    end
  end

  ##
  # This action sets values that are used by new credit card information page .
  #
  # Story: Add new Credit Card https://www.pivotaltracker.com/story/show/38554953
  # Story card not yet implemented
  # @param: search
  #
  # @return
  #
  def new
    @credit_info = CreditInfo.new
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @credit_info }
    end
  end

  ##
  # This action sets values that are used by manage credit info page.
  #
  # Story Card : https://www.pivotaltracker.com/story/show/38554919
  # Story not yet fully implemented
  #
  # @param: search, id
  #
  # @return
  def edit
    @credit_info = CreditInfo.find(params[:id])
    @search = Item.search(params[:search])
  end

  ##
  # This action sets values that are used by create new credit card information
  #
  # Story: Add new Credit Card https://www.pivotaltracker.com/story/show/38554953
  # Story card not yet implemented
  # @param: search
  #
  # @return
  def create
    @credit_info = CreditInfo.new(params[:credit_info])
    @search = Item.search(params[:search])
    respond_to do |format|
      if @credit_info.save
        format.html { redirect_to @credit_info, notice: 'Credit info was successfully created.' }
        format.json { render json: @credit_info, status: :created, location: @credit_info }
      else
        format.html { render action: "new" }
        format.json { render json: @credit_info.errors, status: :unprocessable_entity }
      end
    end
  end


  ##
  # This action sets values that are used by edit credit card info page.
  #
  # Story Card : https://www.pivotaltracker.com/story/show/38554919
  # Story not yet fully implemented
  #
  # @param: search, id
  #
  # @return
  #
  def update
    @credit_info = CreditInfo.find(params[:id])
    @search = Item.search(params[:search])
    respond_to do |format|
      if @credit_info.update_attributes(params[:credit_info])
        format.html { redirect_to @credit_info, notice: 'Credit info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credit_info.errors, status: :unprocessable_entity }
      end
    end
  end


  ##
  # This action deletes a credit card from database
  #
  #
  # Story Card : https://www.pivotaltracker.com/story/show/38555111
  #
  # @param: id
  #
  # @return
  #
  def destroy
    @credit_info = CreditInfo.find(params[:id])
    @credit_info.destroy
    @search = Item.search(params[:search])
    respond_to do |format|
      format.html { redirect_to credit_infos_url }
      format.json { head :no_content }
    end
  end

  def confirm_login
    if !user_signed_in?
      redirect_to(:controller => 'home',:action => 'index')
      return false
    else
      return true
    end
  end
end
