Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks
  resources :users, only:[:new, :create, :show]
  resources :sessions, only:[:new, :create, :destroy]
  resources :labels, only:[:new, :create]
  resources :labelings, only:[:create, :destroy]
end
