Rails.application.routes.draw do
  devise_for :users

  get '/find_business' => 'businesses#find_business'
  post '/sign_up' => 'users#sign_up'
  post '/sign_in' => 'users#sign_in'

  resources :users

  root 'users#test'

  resources :questions
  resources :businesses




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
