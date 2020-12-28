Rails.application.routes.draw do
  resources :dashboard, only: %i[index]
  resources :events
  resources :rules do
    resources :conditions
  end
  resources :rewards

  post '/graphql', to: 'graphql#execute'

  root to: 'dashboard#index'
end
