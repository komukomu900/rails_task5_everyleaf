Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  resources :users except: :index
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users do
      member do
        get :change_admin
      end
    end
  end
end