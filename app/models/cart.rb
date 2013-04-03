class Cart < ActiveRecord::Base
  ##
  # The cart model holds the items the user wants to buy
  #
  # title: title for the cart
  # body: details
  # quantity: number of items
  # total_price: total price which is price*quantity
  #
  # ER Diagram: https://docs.google.com/file/d/0BxEsNfM_qknKa0UtNEQzaGRGVm8/edit
  #
  # Each card belongs to a user
  ##
  attr_accessible :title, :body, :quantity, :total_price
  has_many :line_items, :dependent => :destroy

  ##
  #Add a new product to cart, verify if it is already present and if it is available
  #Also determine the type of the item, whether it is added to wishlist or to buy
  def add_product(item_id,user_id,line_item_type)
	current_item = line_items.where(:item_id => item_id,:user_id=>user_id,:line_item_type => line_item_type).first
  item = Item.find(item_id)
    if line_item_type.to_i!=0
      -1
    elsif current_item
      if(item.availability<=current_item.quantity && current_item.line_item_type.to_i==0)
            -1
      else
        current_item.quantity += 1
        current_item
      end
    else
      if(item.availability<=0  && line_item_type.to_i==0)
            -1
      else
        current_item = LineItem.new(:item_id=>item_id,:user_id=>user_id,:line_item_type => line_item_type)
        line_items << current_item
        current_item
      end
    end
  end

##
#Calculate total price by summing up individual prices
  def total_price
          sum = 0
    line_items.to_a.sum do |check|
      check.total_price.to_i
  end
	
end

end
