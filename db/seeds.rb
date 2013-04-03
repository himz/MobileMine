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

User.create(:password => '123456',:email=>'pathorn.tengkiattrakul@sv.cmu.edu',:first_name =>'Ohm', :last_name => 'Pathorn', :phone_number=>'012345678', :user_type=> 2, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'givemea@givemea.com',:first_name =>'Givemea', :last_name => 'givemea', :phone_number=>'012345678', :user_type=> 0, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'buyer@givemea.com',:first_name =>'buyer', :last_name => 'buyer', :phone_number=>'012345678', :user_type=> 1, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'manask88@gmail.com',:first_name =>'Manuel', :last_name => 'N', :phone_number=>'012345678', :user_type=> 1, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'givemea.mobilemine@gmail.com',:first_name =>'givemea', :last_name => 'admin', :phone_number=>'012345678', :user_type=> 0, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'swati.singh@sv.cmu.edu',:first_name =>'Swati', :last_name => 'Singh', :phone_number=>'012345678', :user_type=> 1, :zipcode=>15312, :address=>'somewhere' )
User.create(:password => '123456',:email=>'seller@givemea.com',:first_name =>'Seller', :last_name => 'givemea', :phone_number=>'012345678', :user_type=> 2, :zipcode=>15312, :address=>'somewhere' )

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

Item.create(:name => 'HTC Desire X', :price => '500', :image_url => '/upload_image/HTC-Desire-X-0-jpg.jpg', :description => 'HTC Desire X is a beautiful 4.0-inch mid-range Android device. It looks very similar to the dual-SIM Desire V, but this time it is a single-SIM affair. The 4.0-inch LCD screen features WVGA, or 480 x 800-pixel resolution. HTC has packed this with a Qualcomm dual-core Snapdragon S4 chip clocked at 1GHz. This however is not one of the monster 28nm chips seen in high-end devices, but rather a very modest Cortex A5 chip made using 45nm technology. Dubbed S4 Play, the chip stutters with more intensive tasks, but you would expect this of a mid-range device after all. The Desire X features a 5-megapixel camera that should be a pretty decent shooter with backside illuminated sensor, HTC own ImageChip and best of all some of the camera features we have seen on higher end models like fast activation, burst shots (but much slower, at 2 frames per second) and VideoPic that allows you to take still while you record video. Sadly, video recording maxes out at 480p, there is no 720p. The device also comes with Beats Audio.', :availability => 5,:manufacturer =>'HTC',:featured =>'1',:user_id=>1)
Item.create(:name => 'HTC Droid Incredible 4G', :price => '600', :image_url => '/upload_image/HTC-DROID-Incredible-4G-LTE-0-jpg.jpg', :description => "HTC DROID Incredible 4G LTE is the newest addition to the Droid family. It is a decent device, but seems a bit short on specs for the price. Judge for yourself: it has got a 0.46-inch thin frame, a 4-inch qHD LCD screen, a 1.2GHz dual-core processor backed up with 1GB of RAM, and an 8-megapixel rear camera captures 1080p video, while there is also a front-facing VGA shooter, good for video conferencing. All of this runs on the latest Android 4.0 Ice Cream Sandwich skinned up with HTC Sense 4.0.", :availability => 5,:manufacturer =>'HTC',:featured =>'1',:user_id=>1)
Item.create(:name => 'HTC Droid DNA', :price => '400', :image_url => '/upload_image/HTC-DROID-DNA-0-jpg.jpg', :description => "HTC put everything it is capable of into the latest surprise for the year, its DROID DNA behemoth announced as a Verizon exclusive. The phones main selling point is its large 5 inc edge-to-edge screen with Full HD resolution, the first of its kind with 440ppi pixel density, which is a sight to behold. Every major hardware and software improvement the company has come up with lately are also thrown in there, like Beats Audio and dedicated speaker amplifiers, wide-angle front camera, the ImageChip ISP and latest Sense 4+, plus HTC has wrapped it all up in a very slim and elegant for this screen size chassis.", :availability => 3,:manufacturer =>'HTC',:featured =>'1',:user_id=>1)
Item.create(:name => 'HTC Windows Phone 8', :price => '630', :image_url => '/upload_image/HTC-Windows-Phone-8X-0-jpg.jpg', :description => "HTC Windows Phone 8X is companys flagship Windows Phone 8 coming with a powerful spec sheet wrapped in a svelte 0.39 body in nice candy colors. The 8X by HTC sports a 4.3 LCD 2 HD screen, which, if the One X display is any indication, should be a sight to behold, and has the respectable 342ppi pixel desnity. It ups the WP ante with a modern 28mm dual-core 1.5GHz Snapdragon S4 chipset, 1GB of RAM and 16GB of internal memory, thus equating its specs with the fierce WP8 competition in the face of the Samsung ATIV S, or the innnovative Nokia Lumia 920, which, however, has a lot more going for it with the PureView camera. How does the HTC 8X intend to differentiate from those? Why, Beats Audio, of course. The prominent branding is featured proudly on the back of the phone, promising deep bass sound and clearer audio. The Windows Phone 8X by HTC featuring Beats Audio also offers a unique audio amplifier powering the 3.5mm audio jack and the speaker, boosting the audio signal for even better sound no matter if you are listening to music, playing a game or watching a video, says HTC. As for the sniping capabilities, we have an 8MP shooter on the rear with dedicated shutter key, equipped with HTCs exclusive ImageSense technology, which is essentially a proprietary ISP, allowing for some additional photo trickery, like ultra fast capture times, and continuous shot mode that takes multiple frames per second. It sports ultra wide f/2.0 aperture, just like on the Lumia 920. What is even more interesting, is that the 2MP front-facing shooter is with the same ultra wide 88 degree angle, allowing up to four people and more to be captured at once, and can shoot 1080p video as well, which should make for some pretty clean and crowded Skype video calls.", :availability => 3,:manufacturer =>'HTC',:featured =>'1',:user_id=>1)
Item.create(:name => 'HTC Sensation XL', :price => '300', :image_url => '/upload_image/HTC-Sensation-XL-0-jpg.jpg', :description => 'HTC Sensation XL will surely impress those who are looking for something earth shattering in the Android World. In addition to the obvious 4.7 WVGA display with Gorilla Glass that it is packing, the handset is known to be a fine image snapper with its 8-megapixel auto focus camera with backside illumination, f/2.2 28mm lens, and dual-LED flash. However, it is still only limited to 720p HD video capture with a 1.3-megapixel front-facing camera. Providing its core horsepower, the Sensation XL is powered by a 1.5GHz single core Qualcomm Snapdragon processor, which is coupled with 768MB of RAM, to offer a rich and satisfying Sense 3.0 experience running on top of Android 2.3 Gingerbread. Of course, it features other standards such as 16GB of internal storage, GPS, Wi-Fi, and HSPA+ connectivity for theoretical download and upload speeds of 14.4Mbit/s and 5.67Mbits/s. With Beats Audio technology producing some thumping tunes, the handset is being shipped along with urBeats headphones, which integrates perfectly with the handset is audio centric focus as well.', :availability => 5,:manufacturer =>'HTC',:featured =>'1',:user_id=>1)
Item.create(:name => 'Sony Xperia Edual Pictures', :price => '500', :image_url => '/upload_image/Sony-Xperia-E-dual-0-jpg.jpg', :description => 'Sony Xperia E dual is an affordable and compact dual SIM handset. The stand-out feature Sony wants us to note in the Xperia E is HD Voice, the purpose of which is to noticeably boost the sound quality of phone calls. When it comes to specs, the Xperia E will deliver a mid-range experience with its 3.5 HVGA touchscreen and 1GHz processor. Lets hope that Jelly Beans Project Butter will help get rid of the lag. Sony also claims that we will be surprised by the battery life of the device. The 1500 mAh battery will benefit from a special extended stand-by mode designed to increase overall battery life. Basically, when the phone sleeping, it will disable all functions except for calling and messaging, and once you wake it up, all functions will be restored to their normal state. Of course, users will be able to enjoy Sony "Walkman" music experience, as well as the xLOUD sound technology, which works really well in most Sony smartphones.', :availability => 5,:manufacturer =>'Sony',:featured =>'1',:user_id=>1)
Item.create(:name => 'Samsung GALAXY Note II US Cellular', :price => '600', :image_url => '/upload_image/Samsung-GALAXY-Note-II-US-Cellular-0-jpg.jpg', :description => 'Galaxy is very good.', :availability => 4,:manufacturer =>'Samsung',:featured =>'1',:user_id=>1)
Item.create(:name => 'Samsung Galaxy S III Cricket', :price => '700', :image_url => '/upload_image/Samsung-Galaxy-S-III-Cricket-0-jpg.jpg', :description => 'Galaxy is very good.', :availability => 3,:manufacturer =>'Samsung',:featured =>'1',:user_id=>1)
Item.create(:name => 'Samsung Galaxy Premier', :price => '600', :image_url => '/upload_image/Samsung-Galaxy-Premier-0-jpg.jpg', :description => 'Galaxy is very good.', :availability => 3,:manufacturer =>'Samsung',:featured =>'1',:user_id=>1)
Item.create(:name => 'Samsung Galaxy Premier', :price => '600', :image_url => '/upload_image/Samsung-Galaxy-Premier-0-jpg.jpg', :description => 'Galaxy is very good.', :availability => 3,:manufacturer =>'Samsung',:featured =>'1',:user_id=>1)
Item.create(:name => 'Google Nexus 4', :price => '500', :image_url => '/upload_image/Google-Nexus-4-0-jpg.jpg', :description => 'LG is very good.', :availability => 3,:manufacturer =>'LG',:featured =>'1',:user_id=>1)
Item.create(:name => 'LG Spectrum 2', :price => '400', :image_url => '/upload_image/LG-Spectrum-2-0-jpg.jpg', :description => 'LG is very good.', :availability => 3,:manufacturer =>'LG',:featured =>'1',:user_id=>1)
Item.create(:name => 'LG Optimus L9 T-Mobile', :price => '450', :image_url => '/upload_image/LG-Optimus-L9-T-Mobile-0-jpg.jpg', :description => 'LG is very good.', :availability => 3,:manufacturer =>'LG',:featured =>'1',:user_id=>1)
Item.create(:name => 'LG Splendor', :price => '450', :image_url => '/upload_image/LG-Splendor-0-jpg.jpg', :description => 'LG is very good.', :availability => 3,:manufacturer =>'LG',:featured =>'1',:user_id=>1)
Item.create(:name => 'Nokia 3310', :price => '10000', :image_url => '/upload_image/nokia-3310.jpeg', :description => 'The Nokia 3310 is a dual band GSM900/1800 mobile phone. Released in the fourth quarter of 2000, it replaced the popular Nokia 3210. This phone sold extremely well, being one of the most successful phones with 126 million units sold.[1] Several variants of the 3310 have been released, including the Nokia 3315, 3320, 3330, 3350, 3360, 3390 and 3395.', :availability => 10,:manufacturer =>'Nokia',:featured =>'1',:user_id=>1)
Item.create(:name => 'Sony Ericsson w810', :price => '100', :image_url => '/upload_image/w810.jpeg', :description => 'The W810 (available as the W810i and W810c) is a camera phone produced by Sony Ericsson. It was released in April 2006. It is the successor of the W800.', :availability => 10,:manufacturer =>'Sony Ericsson',:featured =>'1',:user_id=>1)

Item.create(:name => 'LG Splendor', :price => '400', :image_url => '/upload_image/LG-Splendor-0-jpg.jpg', :description => 'LG is very good.', :availability => 3,:manufacturer =>'LG',:featured =>'1',:user_id=>1)
Item.create(:name => 'Nokia 3310', :price => '100', :image_url => '/upload_image/nokia-3310.jpeg', :description => 'The Nokia 3310 is a dual band GSM900/1800 mobile phone. Released in the fourth quarter of 2000, it replaced the popular Nokia 3210. This phone sold extremely well, being one of the most successful phones with 126 million units sold.[1] Several variants of the 3310 have been released, including the Nokia 3315, 3320, 3330, 3350, 3360, 3390 and 3395.', :availability => 10,:manufacturer =>'Nokia',:featured =>'1',:user_id=>1)
Item.create(:name => 'Sony Ericsson w810v', :price => '100', :image_url => '/upload_image/w810.jpeg', :description => 'The W810 (available as the W810i and W810c) is a camera phone produced by Sony Ericsson. It was released in April 2006. It is the successor of the W800.', :availability => 10,:manufacturer =>'Sony Ericsson',:featured =>'1',:user_id=>1)


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

ItemCategory.create(:category_id => 1, :item_id => 28)
ItemCategory.create(:category_id => 1, :item_id => 29)
ItemCategory.create(:category_id => 1, :item_id => 30)
ItemCategory.create(:category_id => 1, :item_id => 31)
ItemCategory.create(:category_id => 1, :item_id => 32)
ItemCategory.create(:category_id => 1, :item_id => 33)
ItemCategory.create(:category_id => 1, :item_id => 34)
ItemCategory.create(:category_id => 1, :item_id => 35)
ItemCategory.create(:category_id => 1, :item_id => 36)
ItemCategory.create(:category_id => 1, :item_id => 37)
ItemCategory.create(:category_id => 1, :item_id => 38)
ItemCategory.create(:category_id => 1, :item_id => 39)
ItemCategory.create(:category_id => 1, :item_id => 40)
ItemCategory.create(:category_id => 1, :item_id => 41)

ItemCategory.create(:category_id => 2, :item_id => 42)
ItemCategory.create(:category_id => 2, :item_id => 43)

ItemCategory.create(:category_id => 2, :item_id => 44)
ItemCategory.create(:category_id => 2, :item_id => 45)
ItemCategory.create(:category_id => 2, :item_id => 46)




Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>24, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>25, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>26, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>27, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>2, :state=>0, :item_quantity => 2, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>3, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>4, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>1, :item_id=>5, :state=>3, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>4, :seller_id=>1, :item_id=>6, :state=>3, :item_quantity => 3, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>7, :item_id=>44, :state=>0, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>3, :seller_id=>7, :item_id=>45, :state=>3, :item_quantity => 1, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)
Order.create(:buyer_id=>4, :seller_id=>7, :item_id=>46, :state=>3, :item_quantity => 3, :shipping_address=>'Shipping Test Address 1', :billing_address =>'Billing Address 1', :price => 10,:total_price=>10,:transaction_id=>1)


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
