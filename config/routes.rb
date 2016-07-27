Rails.application.routes.draw do
  resources :recommendations
  devise_for :users

  get '/find_business' => 'businesses#find_business'
  post '/claim' => 'businesses#claim'
  post '/sign_up' => 'users#sign_up'
  post '/sign_in' => 'users#sign_in'

  resources :users

  root 'users#test'

  resources :businesses
  resource :surveys
  get '/surveys/matches' => 'surveys#matches'

  resources :questions
  get '/questions/all' => 'questions#all'

  resources :answers





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
