Rails.application.routes.draw do
  devise_for :admins, :skip => [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'blog/home#index'
  get 'backoffice', to: 'backoffice/dashboard#index'
  
  namespace :backoffice do
    resources :dashboard, only:[:index]
    resources :posts, only:[:index, :new, :create, :edit, :update, :destroy]
    resources :categories, only:[:index, :new, :create, :edit, :update, :destroy]
    resources :admins, only:[:index, :new, :create, :edit, :update, :destroy]
    resources :admin_profiles, only: [:edit, :update]
    get 'dashboard', to: 'dashboard#index'
  end
  
  namespace :blog do
    get 'home', to:'home#index'
    get 'search_date', to:'search#by_date'
  end
  
end
