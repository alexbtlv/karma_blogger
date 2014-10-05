require "spec_helper"

describe "posts/best" do
	it "renders a post preview" do	
		user = User.create!(:name => "User", :email => "User@example.com", :password => "foobar", :password_confirmation => "foobar") 
		assign(:posts, [
			user.posts.create!(:title => "Title", :body => "Post body"),
			user.posts.create!(:title => "Title", :body => "Post body")
			])

		render :template => "posts/_post_preview.html.erb", :locals => {:posts => :posts}
		expect(rendered).to match /Title/
		expect(rendered).to match /Post body/
	end

	# it "renders the post partial for each post" do
	#     assign(:post, [
	#       double(:name => "First"),
	#       double(:name => "Second")
	#     ])
	#     stub_template "posts/_post_preview.html.erb" => "<%= post.name %><br/>"
	#     render
	#     expect(rendered).to match /First/
	#     expect(rendered).to match /Second/
	# end
end