# config/routes.rb

Rails.application.routes.draw do
  # Existing routes
  root to: redirect('/homepage')
  get '/homepage', to: 'homepage#index'

  # Devise routes for users
  devise_for :users
  # If you need custom paths for Devise, you can configure them here, e.g.:
  # devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' }
end
