Rails.application.routes.draw do

  # Set Project Root Directory #
  root 'static_pages#home'

  # Set Project Static Page Directories #
  get '/help',      to: 'static_pages#help'
  get '/about',     to: 'static_pages#about'
  get '/contact',   to: 'static_pages#contact'

  # Set Project User Directories #
  get    '/signup',    to: 'users#new'
  post   '/signup',    to: 'users#create'
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'

  # Set Proejct Resources #
  resources :users

end
