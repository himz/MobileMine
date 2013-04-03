# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(:name => 'Smart Phones')
Category.create(:name => 'Feature Phones')
Category.create(:name => 'Simple Phones')
Category.create(:name => 'Tablets')
Category.create(:name => 'Accessories')

User.create(:password => '123456',:email=>'givemea@givemea.com',:first_name =>'givemea', :last_name => 'givemea', :phone_number=>'012345678', :user_type=> 0, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'seller@givemea.com',:first_name =>'seller', :last_name => 'seller', :phone_number=>'012345678', :user_type=> 1, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'buyer@givemea.com',:first_name =>'buyer', :last_name => 'buyer', :phone_number=>'012345678', :user_type=> 1, :zipcode=>15312, :address=>'somewhere' )

Item.create(:name => 'Iphone 5', :price => '500', :image_url => '/upload_image/iphone5.jpg', :description => 'Apple is launching its most awaited Iphone 5 with more exciting features and dimensions. Earlier, there had been a lot of rumors about the launching date. But now some sources confirm that it will be launched on Oct 4th, in a media event with the slogan', :availability => 1,:manufacturer =>'apple',:featured =>'1',:user_id=>1)
Item.create(:name => 'Galaxy S4', :price => '400', :image_url => '/upload_image/galaxys4.jpg', :description => 'best phone ever', :availability => 0,:manufacturer =>'apple',:featured =>'1',:user_id=>1)
Item.create(:name => 'Nexus 7', :price => '300', :image_url => '/upload_image/nexus7.jpg', :description => 'xyz', :availability => 1,:manufacturer =>'apple',:featured =>'1',:user_id=>1)
Item.create(:name => 'Galaxy S2', :price => '150', :image_url => '/upload_image/galaxys2.jpg', :description => 'best phone ever', :availability => 0,:manufacturer =>'apple',:featured =>'1',:user_id=>1)
Item.create(:name => 'HTC ONE X', :price => '450', :image_url => '/upload_image/htcone.png', :description => 'best phone ever', :availability => 0,:manufacturer =>'htc',:featured =>'1',:user_id=>1)
Item.create(:name => 'Iphone', :price => '500', :image_url => '/upload_image/iphone5.jpg', :description => 'xyz', :availability => 1,:manufacturer =>'apple',:featured =>'1', :user_id=>1)
    Item.create(:name => 'Galaxy4', :price => '400', :image_url => '/upload_image/galaxys4.jpg', :description => 'best phone ever', :availability => 0,:manufacturer =>'apple',:featured =>'1', :user_id=>1)
    Item.create(:name => 'Iphone3', :price => '500', :image_url => '/upload_image/iphone5.jpg', :description => 'xyz', :availability => 1,:manufacturer =>'apple',:featured =>'1', :user_id=>1)
    Item.create(:name => 'Galaxy', :price => '400', :image_url => '/upload_image/galaxys23.jpg', :description => 'best phone ever', :availability => 0,:manufacturer =>'apple',:featured =>'1', :user_id=>1)
    Item.create(:name => 'Galaxy2', :price => '450', :image_url => '/upload_image/galaxys2.jpg', :description => 'best phone ever', :availability => 0,:manufacturer =>'apple',:featured =>'1', :user_id=>1)
    Item.create(:name => 'Car Charger', :price=> '10', :image_url => '/upload_image/belkincarcharger.jpeg', :description=>'Universal car charger, works for iphones, ipods, can be used in most cars', :availability => 1, :manufacturer=>'belkin', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Iphone Charger', :price=> '20', :image_url => '/upload_image/cariphonecharger.jpeg', :description=>'Works only with iphones', :availability => 1 , :manufacturer=>'local', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Bose Headset', :price=> '200', :image_url => '/upload_image/boseheadset.jpg', :description=>'Bose earphones, super sound quality', :availability => 1, :manufacturer=>'Bose', :featured=>'1', :user_id=>1)
    Item.create(:name => 'Slip Pad', :price=> '20', :image_url => '/upload_image/carslippad.jpeg', :description=>'Excellent for regular drivers. Hold your iphone against the dashboard of your car', :availability => 1, :manufacturer=>'local', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Iphone Cover', :price=> '20', :image_url => '/upload_image/halloweencover.jpg', :description=>'iphone cover. Make your iphone look like a daemon, scare fields', :availability => 1, :manufacturer=>'local', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Iphone Cover', :price=> '2', :image_url => '/upload_image/hellokittycover.jpg', :description=>'iphone cover. Make your iphone look like a cute cat', :availability => 1, :manufacturer=>'local', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Kingston 8GB', :price=> '15', :image_url => '/upload_image/kingston8memory.jpeg', :description=>'Add external memory to your phone', :availability => 1, :manufacturer=>'Kingston', :featured=>'1', :user_id=>1)
    Item.create(:name => 'Sandisk 16GB', :price=> '35', :image_url => '/upload_image/sandisk16memory.jpeg', :description=>'Add external memory to your phone', :availability => 1, :manufacturer=>'Sandisk', :featured=>'1', :user_id=>1)
    Item.create(:name => 'Motorola Headset', :price=> '35', :image_url => '/upload_image/motorolaheadset.jpg', :description=>'Talk using bluetooth, handsfree', :availability => 1, :manufacturer=>'Motorola', :featured=>'1', :user_id=>1)
    Item.create(:name => 'Platonic Headset', :price=> '35', :image_url => '/upload_image/platonicheadset.jpg', :description=>'Talk using bluetooth, handsfree', :availability => 1, :manufacturer=>'Platonic', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Philips Headset', :price=> '10', :image_url => '/upload_image/philipsheadset.jpeg', :description=>'Earphones, works with any phone, excellent for music or calls', :availability => 1, :manufacturer=>'Philips', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Samsung Headset', :price=> '10', :image_url => '/upload_image/samsungstereo.jpeg', :description=>'Earphones, works with any phone, excellent for music or calls', :availability => 1, :manufacturer=>'Samsung', :featured=>'1', :user_id=>1)
    Item.create(:name => 'Nexus Cover', :price=> '10', :image_url => '/upload_image/nexuscover.png', :description=>'Protect your phone from water and dust', :availability => 1, :manufacturer=>'local', :featured=>'0', :user_id=>1)
    Item.create(:name => 'Nexus Screenguard', :price=> '10', :image_url => '/upload_image/nexusscreenguard.jpg', :description=>'Protect your phone from water and dust', :availability => 1, :manufacturer=>'local', :featured=>'1', :user_id=>2)
    Item.create(:name => 'Nokia Battery', :price=> '10', :image_url => '/upload_image/nokiabattery.jpeg', :description=>'Battery replacement', :availability => 1, :manufacturer=>'Nokia', :featured=>'0', :user_id=>2)
    Item.create(:name => 'Samsung Battery', :price=> '10', :image_url => '/upload_image/samsungbattery.jpeg', :description=>'Battery replacement', :availability => 1, :manufacturer=>'Samsung', :featured=>'0', :user_id=>2)
    Item.create(:name => 'Sandisk 16GB', :price=> '35', :image_url => '/upload_image/sandisk16memory.jpeg', :description=>'Add external memory to your phone', :availability => 1, :manufacturer=>'Sandisk', :featured=>'1', :user_id=>2)

ItemCategory.create(:category_id => 1, :item_id => 1)
ItemCategory.create(:category_id => 1, :item_id => 2)
ItemCategory.create(:category_id => 1, :item_id => 4)
ItemCategory.create(:category_id => 4, :item_id => 3)
ItemCategory.create(:category_id => 5, :item_id => 11)
ItemCategory.create(:category_id => 5, :item_id => 12)
ItemCategory.create(:category_id => 5, :item_id => 13)
ItemCategory.create(:category_id => 5, :item_id => 14)
ItemCategory.create(:category_id => 5, :item_id => 15)
ItemCategory.create(:category_id => 5, :item_id => 16)
ItemCategory.create(:category_id => 5, :item_id => 17)
ItemCategory.create(:category_id => 5, :item_id => 18)
ItemCategory.create(:category_id => 5, :item_id => 19)
ItemCategory.create(:category_id => 5, :item_id => 20)
ItemCategory.create(:category_id => 5, :item_id => 21)
ItemCategory.create(:category_id => 5, :item_id => 22)
ItemCategory.create(:category_id => 5, :item_id => 23)
ItemCategory.create(:category_id => 5, :item_id => 24)
ItemCategory.create(:category_id => 5, :item_id => 25)
ItemCategory.create(:category_id => 5, :item_id => 26)
ItemCategory.create(:category_id => 5, :item_id => 27)



MORE_ITEMS = [

 ]




  def up
    MORE_ITEMS.each do |item|
      Item.create!(item)
    end
  end

  def down
    MORE_ITEMS.each do |item|
      Item.find_by_name(item[:name]).destroy
    end
  end
