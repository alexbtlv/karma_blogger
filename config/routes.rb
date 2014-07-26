Rails.application.routes.draw do
	get '@' + ':id', to: 'profile#show', :as => :profile
	devise_for :users, path: "auth", path_names: { sign_in: 'sign_in', sign_out: 'sign_out', password: 'password', confirmation: 'verification', registration: 'register', sign_up: 'cmon_let_me_in' }
	root to: "posts#index"
	resources :posts, path_names: { new: 'new-story' }, :path => ''
end