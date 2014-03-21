DirtyLaundry::Application.routes.draw do
  post 'users/create' => 'users#create'
  get 'users/new' => 'users#new', as: :sign_up

  get 'sessions/new' => 'sessions#new', as: :log_in
  delete 'sessions' => 'sessions#destroy', as: :log_out

  get '/auth/:provider/callback' => 'authentications#create'

  resources :scans

  


  



  get 'dashboard1' => 'dashboards#dashboard1'
  get 'dashboard2' => 'dashboards#dashboard2'
  get 'dashboard3' => 'dashboards#dashboard3'

  get 'application' => 'application#home', as: :splash
  root "application#home" 

  ### devise_for :users, controllers: { sessions: "users/sessions" }


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
