Rails.application.routes.draw do
  

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount_opro_oauth
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'rails_admin/main#dashboard'
  # get 'home/index' => 'home#index'
  get "/privacy" => "staticpage#privacy_policy" #for api
  get "/tc" => "staticpage#terms_condition" # for api
   get "/qf" => "staticpage#QF"

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get  '/place'      => "googleapi#place"
      get  '/newplace'      => "googleapi#newplace"
      post  '/place_details'      => "googleapi#place_details"
      get  '/placewithfilter'      => "googleapi#placewithfilter"
      get  '/place_old'      => "googleapi#place_old"
      get  '/review'      => "googleapi#review"
      resources :users do
        collection do
            post :logout
          end
      end
      resources :foods
      resources :food_reviews
    end
  end

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
