require "spec_helper"

describe "posts/edit" do
	before(:each) do
		@user = assign(:user, User.create!(:name => "User", :email => "User@example.com", :password => "foobar", :password_confirmation => "foobar"))
		@post = assign(:post, @user.posts.create!(:title => "title", :body => "Post body"))
	end

	it "renders the edit post form" do

		render :template => "posts/edit"

		assert_select "form[action=?][method=?]", post_path(@post), "post" do
      		assert_select "input#post_title[name=?]", "post[title]"
   		end
	end
end