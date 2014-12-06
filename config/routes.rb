Rails.application.routes.draw do

  root 'static_pages#home'

  resources :users, only: [:create, :update]
  get 'signup' => 'users#new'
  get 'users/:id/settings' => 'users#edit', as: 'settings'

  get 'signin' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  get 'activate/:token' => 'account_activations#edit', as: 'edit_account_activation'
  get 'resend-activation' => 'account_activations#new', as: 'new_account_activation'
  post 'resend-activation' => 'account_activations#create', as: 'account_activations'

  get 'reset-password' => 'password_resets#new', as: 'new_password_reset'
  post 'reset-password' => 'password_resets#create', as: 'password_resets'
  get 'change-password/:token' => 'password_resets#edit', as: 'edit_password'
  patch 'reset-password' => 'password_resets#update'

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