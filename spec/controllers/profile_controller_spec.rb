require 'spec_helper'

describe ProfileController do

	let!(:user) { create(:user) }
	let(:valid_attributes) { { "title" => "My title", "body" => "This is the text for body"} }

	describe "GET show" do
		it "assigns the requested user as @user" do
			get :show, { :id => user.to_param }
			expect(assigns(:user)).to eq(user)  
		end

		it "assigns the posts of user as @posts" do
			post = user.posts.create! valid_attributes
			get :show, { :id => user.to_param }
			expect(assigns(:posts).map(&:user)).to eq([user])
		end
	end

end
