Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'password', confirmation: 'verification', registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: "posts#index"
  resources :posts
end