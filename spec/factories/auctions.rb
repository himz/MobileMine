# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auction do
    item_id 1
    seller_id 1
    bid_amount 100
    highest_bidder 2
    state 1
    end_time Time.now+60*5
  end
end
