module ApplicationHelper
	def karma_for(user)
		@posts = user.posts.all
		@karma = @posts.inject(0){|sum, post| sum + post.votes_for.size}
	end
end
