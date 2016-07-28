Rails.application.routes.draw do
  resources :recommendations
  devise_for :users

  get '/find_business' => 'businesses#find_business'
  post '/claim' => 'businesses#claim'
  post '/sign_in' => 'api#sign_in'
  post '/sign_up' => 'api#sign_up'
  post '/sign_out' => 'api#sign_out'

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
