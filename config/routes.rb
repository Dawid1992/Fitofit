Rails.application.routes.draw do
  devise_for :users
  root to: 'activities#new'
  get '/activities', to: 'activities#index'
  resources :activities, only: %i[new create show]
end
