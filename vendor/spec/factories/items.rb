FactoryGirl.define do
  factory :item do
    name "Galaxy S2"
    image_url "testURL"
    price "400"
    availability "yes"
    description "best phone ever"
    manufacturer "Samsung"
    sold_count 0
    featured true
    user_id 1
  end


  factory :invalid_item, parent: :item do
    name nil
  end
end


