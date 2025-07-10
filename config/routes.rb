Rails.application.routes.draw do
  root to: redirect('/homepage')

  devise_for :users

  get '/homepage', to: 'homepage#index'
end
