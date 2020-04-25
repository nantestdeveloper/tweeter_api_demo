Rails.application.routes.draw do
  get 'welcomes/index'
  root to: "welcomes#index"
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resource :tweets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
