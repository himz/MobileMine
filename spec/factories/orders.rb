# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    buyer_id 1
    seller_id 3
    item_id 1
    state 1
    billing_address "somewhere in earth"
  end
end
