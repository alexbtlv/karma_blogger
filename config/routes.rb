Rails.application.routes.draw do
	
	get '@' + ':id', to: 'profile#show', :as => :profile
	get 'fresh', to: 'posts#fresh', :as => :fresh_posts
	devise_for :users, path: "auth", path_names: { sign_in: 'sign_in', sign_out: 'sign_out', password: 'password', confirmation: 'verification', registration: 'register', sign_up: 'cmon_let_me_in' }
	root to: "posts#best"
	
	resources :posts, path_names: { new: 'new-story' }, :path => '' do
		member do
			patch 'karma_up', to: 'posts#karma_up'
        	patch 'karma_down', to: 'posts#karma_down'
		end
	end
end