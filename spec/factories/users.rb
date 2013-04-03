# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Manuel"
    last_name "Nakamurakare"
    zipcode 15213
    address "forbes avenue"
    email "givemea@gmailssdsdsd.com"
    phone_number "12312343344"
    user_type 1
    password "secret"
  end

  factory :admin_user, parent: :user do
    email "admin@givemea.com"
    user_type 0
  end
  factory :seller, parent: :user do
    email "seller@givemea.com"
    user_type 2
  end
end
