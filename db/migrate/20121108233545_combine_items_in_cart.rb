class CombineItemsInCart < ActiveRecord::Migration

def self.up
# replace multiple items for a single product in a cart with a single item 
Cart.all.each do |cart|
    # count the number of each product in the cart
    sums = cart.line_items.group(:item_id).sum(:quantity)

	sums.each do |item_id, quantity| 
		if quantity > 1
        	# remove individual items
        	cart.line_items.where(:item_id=>item_id).delete_all
       	    # replace with a single item
       	    cart.line_items.create(:item_id=>item_id, :quantity=>quantity, :user_id =>user_id)
	end
      end
   end 
end
def self.down
# split items with quantity>1 into multiple items
LineItem.where("quantity>1").each do |lineitem|
    # add individual items
		lineitem.quantity.times do
			LineItem.create :cart_id=>lineitem.cart_id,
        		:item_id=>lineitem.item_id, :quantity=>1,
            :user_id=>user_id
		end
    # remove original item
    	lineitem.destroy
	end
end
end

