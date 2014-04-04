DirtyLaundry::Application.routes.draw do

  ### Application home and splash page
  get 'application' => 'application#home', as: :splash
  get 'nyc' => 'application#nyc', as: :nyc
  root "application#home" 


  ### Authentication
  post 'users/create' => 'users#create'
  get 'users/new' => 'users#new', as: :sign_up
  get 'sessions/new' => 'sessions#new', as: :log_in
  delete 'sessions' => 'sessions#destroy', as: :log_out
  ### Third-party Authentication
  get '/auth/:provider/callback' => 'authentications#create'

  ###Scans - can be trimmed
  resources :scans

  get '/dashboard/current' => 'dashboards#current', as: :current_dashboard
  get '/dashboard/:id' => 'dashboards#summary', as: :dashboard
  get '/dashboard/:id/analytics' => 'dashboards#analytics'
  get '/dashboard/:id/locations' => 'dashboards#locations'
  get '/dashboard/:id/connections' => 'dashboards#connections'



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
