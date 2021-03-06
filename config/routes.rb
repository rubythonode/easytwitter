Mifd::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
=begin
  namespace :api do
    namespace :v1 do
      resource :tweets
    end
  end
=end
  resources :categories

  namespace :api do
    namespace :v1 do
      resources :tweets do
        collection do
          get 'rank'
          get 'trend'
        end
      end
      resources :user_tweets, only: [:create] 
      resources :users do
        collection do
          post 'follow'
        end
      end
    end
  end

  delete '/api/v1/user_tweets/:tweet_uuid' => 'api/v1/user_tweets#destroy'
  resources :users do
    collection do
      post 'follow'
    end
  end
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'tweets/recent' => 'tweets#recent', as: 'recent_tweets'
  get 'tweets/people' => 'tweets#people', as: 'people_tweets'
  get 'tweets/test' => 'tweets#test'
  get 'categories/recent/:id' => 'categories#recent', as: 'recent_categories'
  get 'categories/people/:id' => 'categories#people', as: 'people_categories'
  root to: 'tweets#recent'
  resources :tweets
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
