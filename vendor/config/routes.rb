BestBay::Application.routes.draw do
  resources :auctions
  match 'auctions/increase_bid' => 'auctions#increase_bid', :as => :auction_increase_bid
  match 'auctions/change_state' => 'auctions#change_state', :as => :auction_change_state
  match 'auctions/close_auction' => 'auctions#close_auction', :as => :auction_close_auction
  match 'seller/update_auction' => 'auctions#seller_edit', :as => :auction_seller_edit
  #CRUD for selling items
  match 'items/new_item' => 'items#new_item', :as => :user_items_new, :via => :get
  match 'items/user_items_list' => 'items#user_items_list', :as => :user_items_index, :via => :get
  match 'items/user_edit_item' => 'items#user_edit_item', :as => :user_items_edit, :via => :get
  match 'items/user_delete_item' => 'items#user_delete_item', :as => :user_items_delete, :via => :get

  resources :credit_infos

  #admin
  match 'admin/users' => 'admin_users#index', :as => :admin_users_index, :via => :get
  match 'admin/users/delete/:id' => 'admin_users#delete', :as => :admin_users_delete, :via => :get
  match 'admin/users/:id' => 'admin_users#show', :as => :admin_users, :via => :get
  match 'admin/users/deactivate/:id' => 'admin_users#deactivate', :as => :admin_users_deactivate, :via => :get
  match 'admin/users/activate/:id' => 'admin_users#activate', :as => :admin_users_activate, :via => :get
  match 'admin/items' => 'admin_items#index', :as => :admin_items_index, :via => :get
  match 'admin/items/delete/:id' => 'admin_items#delete', :as => :admin_items_delete, :via => :get
  match 'admin/items/:id' => 'admin_items#show', :as => :admin_items, :via => :get
  match 'admin/items/deactivate/:id' => 'admin_items#deactivate', :as => :admin_items_deactivate, :via => :get
  match 'admin/items/activate/:id' => 'admin_items#activate', :as => :admin_items_activate, :via => :get

  match 'admin/categories' => 'admin_categories#index', :as => :admin_category_index, :via => :get
  match 'admin/categories/delete/:id' => 'admin_categories#delete', :as => :admin_category_delete, :via => :get
  match 'admin/categories/:id' => 'admin_categories#show', :as => :admin_categories, :via => :get

  match 'orders/track' => 'orders#track', :as => :orders_track, :via => :post
  resources :orders


  devise_for :users , :controllers => {:registrations => "registrations", :sessions => "sessions", :passwords => "passwords"}
  devise_scope :user do
    match "/users/profile" => "registrations#profile" , :as => :users_profile
    match "/users/show" => "registrations#show"
    match "/users/activate_seller" => "registrations#activate_seller", :as => :users_activate_seller
    match "/users/confirm_activate_seller" => "registrations#confirm_activate_seller", :as => :confirm_activate_seller
  end
  resources :categories

  resources :items
  # resources :users


  match 'latest' => 'items#new_items_list', :as => :new_index, :via => :get
  match 'admin_users/items' => 'items#admin_index', :as => :admin_index, :via => :get
  match 'admin_users/' => 'items#admin_index', :as => :admin_index, :via => :get
  match 'admin_users/items/new' => 'items#admin_new', :as => :admin_new, :via => :get
  match 'admin_users/items/edit/:id' => 'items#admin_edit', :as => :admin_edit, :via => :get
  match 'admin_users/items/show/:id' => 'items#admin_show', :as => :admin_show, :via => :get

  match 'orders/create' => 'orders#create', :as => :create_order
  get "home/index"
  root to: 'home#index'
 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin_users do
  #     # Directs /admin_users/products/* to Admin::ProductsController
  #     # (app/controllers/admin_users/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
