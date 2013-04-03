# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :line_item do
    item_id 1
    #product_id 1
    cart_id 1
    #total_price 50.5
    user_id 1
    quantity 3
    line_item_type 0
    auction_id nil
  end
end
