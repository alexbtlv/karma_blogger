class ProfileController < ApplicationController
	def show
		@user = User.find_by_name(params[:id])
		#@posts = @user.posts.all
	end
end
