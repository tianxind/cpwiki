Cpwiki::Application.routes.draw do
  root :to => 'home#index'
  resources :comments
  resources :likes

  devise_for :admin_users
  #ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  devise_for :users
  #ActiveAdmin.routes(self)

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  resources :home do
    collection do 
      get 'search'
      get 'search_by_seme_uke'
      get 'contact_us'
      get 'follow_us'
      get 'join_us'
      get 'donate_us'
    end
  end

  resources :cps do
    collection do 
      get 'choose'
      get 'search'
      get 'redirect_to_cp_or_character'
    end
  end

  resources :characters do
    collection do
      get 'choose'
      get 'search'
      get 'redirect_to_character_info_or_new_character'
    end
  end

  resources :user_infos
  
  resources :photos do
    collection do
      post 'update_profile_image'
      get 'lookup'
      post 'create_web_photo'
    end
  end

  resources :tags
  resources :categories
  resources :helps
  resources :bug_reports
  resources :draft_characters
  resources :draft_cps

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
  # just remember to delete public/index.html

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
