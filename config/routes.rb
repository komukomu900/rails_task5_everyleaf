Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  resources :users do
    member do
      get :task_index
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
end