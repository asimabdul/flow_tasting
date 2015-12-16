Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    get "admin/login" => "devise/sessions#new"
    delete "admin/logout" => "devise/sessions#destroy"
  end

  root "home#index"
  
  namespace :admin do
    resources :wines
    resources :tasting_packages
    resources :events, only: [:index, :show]
  end

  post "user_service/create" => "user_service#create"
  get "guests/rsvp/:invite_key" => "guests#rsvp", as: "register_rsvp"
  put "guests/update" => "guests#update"

  resources :scores, only: [:index, :create, :new] do
    collection do
      get :final
    end
  end

  namespace :events do
    resources :sessions, only: [:new, :create] do
      collection do
        delete :destroy
      end
    end
  end

  resources :events
  
  put "events/:id/:operation" , to: "events#control", as: "event_control"

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
