require 'sidekiq/web'

Rails.application.routes.draw do

  resources :dashboard, only: [:index]
  resources :events
  resources :rules do
    resources :conditions
  end
  resources :rewards
  resources :activities, only: [:index]
  resources :achievements, only: [:index]
  resources :receivers

  post '/graphql', to: 'graphql#execute'

  mount Sidekiq::Web => '/sidekiq'

  root to: 'dashboard#index'
end
