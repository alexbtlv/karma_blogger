require 'spec_helper'

describe "posts#new" do
	before(:each) do
		@user = assign(:user, User.create!(:name => "User", :email => "User@example.com", :password => "foobar", :password_confirmation => "foobar"))
		@post = assign(:post, @user.posts.create!(:title => "title", :body => "Post body"))
	end

	it "render a new post form" do
		render :template => "posts/new"

		assert_select "form[action=?][method=?]", post_path(@post), "post" do
			assert_select "input#post_title[name=?]", "post[title]"
		end
	end
end