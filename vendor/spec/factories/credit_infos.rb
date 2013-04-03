# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :credit_info do
    user_id 1
    credit_card_no "1234567812345678"
    billing_address "MyText"
    zipcode 12345
  end
end
