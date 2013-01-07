MyApp::Application.routes.draw do

  get "friendship/index"

  get "friendship/create"
  post "friendship/create"

  get "friendship/approve"

  get "friendship/ignore"

  get "friendship/delete"

  match 'contests/user_photos/:id' => 'contests#user_photos'
  match  "contests/captions_pending_web/:id"  => 'contests#captions_pending_web'
  match "contests/captions_given_web/:id"  => 'contests#captions_given_web'

  match "contests/my_photos" ,to: 'contests#my_photos'
  match  "contests/captions_pending" , to: 'contests#captions_pending'
  match "contests/captions_given"  , to: 'contests#captions_given'
  post  "microposts/ios_create"    => 'microposts#ios_create'
  resources :photos
  resources :contests
  resources :microposts do
    member do
      post :rate
    end
  end

  post 'sessions/ios_login' => 'sessions#ios_login'
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :users
  resources :friendship



  get "static_pages/help"

  get "static_pages/about"
  get "static_pages/contact"
  match '/', to: 'static_pages#home'
  match 'friendship/index', to: '"friendship#index"'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
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
