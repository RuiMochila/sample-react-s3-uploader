Rails.application.routes.draw do
  
  root 'uploads#new'
  
  resources :uploads, only: [ :new, :create, :index ] do 
    collection do
      get 'presigned_post'
      put 'status'
    end
  end

  concern :has_pictures do
    member do
      get 'pictures'
      post 'set_primary_picture'
      delete 'pictures/:picture_key', action: 'remove_picture'
      # TODO: Add remaining routes
    end
  end

  namespace :api do
    namespace :v1 do
      # TODO: Deprecate this line when everything's under Users and Products for demo
      # Remove standalone pictures and uploads in favor of nested to show polymorphism and concerns
      resources :pictures
      resources :users, concerns: :has_pictures
      resources :products, concerns: :has_pictures
    end
  end

end
