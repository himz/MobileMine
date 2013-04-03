# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :card do
    card_number "4000400040004000"
    cvv "123"
    expiry_date "2014-11-21"
    user_id 1
    user 
  end
end
