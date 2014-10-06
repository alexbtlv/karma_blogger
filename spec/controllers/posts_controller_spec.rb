require 'spec_helper'

describe PostsController do
	let(:valid_attributes) { { "title" => "My title", "body" => "This is the text for body"} }
	let!(:user) { create(:user) }

	describe "GET best" do
		context "when not signed in" do
			it "assigns best posts as @posts" do
				post = user.posts.create! valid_attributes
				get :best
				expect(assigns(:posts)).to   eq([post])
			end
		end
	end

	describe "GET fresh" do
		context "when not signed in" do
			it "assigns fresh posts as @posts" do
				post = user.posts.create! valid_attributes
				get :fresh
				expect(assigns(:posts)).to   eq([post])
			end
		end
	end

	describe "GET show" do
		context "when not signed in" do
			it "assigns requsted post as @post" do
				post = user.posts.create! valid_attributes
				get :show, {:id => post.to_param}
				expect(assigns(:post)).to eq(post)  
			end
		end
	end

	describe "GET new" do
		context "when not signed in" do
			it "it redirects to login path" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "signed in" do
			before { sign_in user }

			it "assigns new post as @post" do
				get :new
				expect(assigns(:post)).to be_a_new(Post)  
			end
		end
	end

	describe "GET edit" do
		context "when not signed in" do
			it "it redirects to login path" do
				post = user.posts.create! valid_attributes
				get :edit, {:id => post.to_param}
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		context "signed in" do
			it "assigns the requsted post as @post" do
				post = user.posts.create! valid_attributes
				sign_in user
				get :edit, {:id => post.to_param}
				expect(assigns(:post)).to eq(post)
				expect(assigns(:post).user).to eq(user)
			end
		end
	end

	describe "POST create" do
		context "when not signed in" do
			it "it redirects to login path" do
				post :create, valid_attributes
				expect(response).to redirect_to(new_user_session_path)
			end

			it "not creates a new post" do
				expect {
					post :create, valid_attributes
				}.to change(Post, :count).by(0)
			end
		end

		context "user signed in" do
			before { sign_in user }

			describe "with valid params" do
				it "creates a new post" do
					expect {
						post :create, {:post => valid_attributes}
					}.to change(Post, :count).by(1)
				end

				it "assigns newly created post as @post" do
					post :create, {:post => valid_attributes}
					expect(assigns(:post)).to   be_a(Post)
					expect(assigns(:post)).to   be_persisted
				end

				it "redirects to created post" do
					post :create, {:post => valid_attributes}
					expect(response).to   redirect_to(post_path(Post.last))
				end

				it "creates a post for the current user" do
					post :create, {:post => valid_attributes}
					post = Post.last
					expect(post.user).to eq(user)  
				end

				it "does not allow users to create posts for other users" do
					other_user = create(:user)
					post :create, {:post => valid_attributes.merge(user_id: other_user.id)}
					post = Post.last
					expect(post.user).to eq(user)
				end		
			end

			describe "with invalid params" do
				it "assigns a newly created but unsaved post as @post" do
					allow_any_instance_of(Post).to  receive(:save).and_return(false)
					post :create, {:post => {"title" => "invalid value"}}
					expect(assigns(:post)).to   be_a_new(Post)
					expect(assigns(:post).user).to eq(user)
				end

				it "re-renders the 'new' template" do
					allow_any_instance_of(Post).to receive(:save).and_return(false)
					post :create, {:post => {"title" => "invalid value"}}
					expect(response).to   render_template("new")
				end
			end
		end
	end

	describe "PUT update" do
		context "when not signed in" do
			it "it redirects to login path" do
				post = user.posts.create! valid_attributes
				put :update, {:id => post.id} 
				expect(response).to redirect_to(new_user_session_path)
			end

			it "not updates the post" do
				post = user.posts.create! valid_attributes
				put :update, {:id => post.id, :title => "Wrong title"}
				expect(post.title).to eq('My title')   
			end
		end

		context "user signed in" do
			before { sign_in user }

			describe "with valid params" do
				it "updates the requsted post" do
					post = user.posts.create! valid_attributes
					expect_any_instance_of(Post).to receive(:update).with({ "title" => "My new title"})
					put :update, { :id => post.to_param, :post => { "title" => "My new title" } }
				end

				it "assigns requsted post as @post" do
					post = user.posts.create! valid_attributes
					put :update, { :id => post.to_param, :post => valid_attributes }
					expect(assigns(:post)).to   eq(post)
					expect(assigns(:post).user).to eq(user)  
				end

				it "redirects to the post" do
					post = user.posts.create! valid_attributes
					put :update, { :id => post.to_param, :post => valid_attributes }
					expect(response).to   redirect_to(post_path(post))
				end
			end

			describe "with invalid params" do
				it "assigns the requested post as @post" do
					post = user.posts.create! valid_attributes
					allow_any_instance_of(Post).to receive(:save).and_return(false)
					put :update, {:id => post.to_param, :post => {"title" => "Wrong title"}}
					expect(assigns(:post)).to   eq(post)
				end

				it "re-renders the 'edit' template" do
					post = user.posts.create! valid_attributes
					allow_any_instance_of(Post).to receive(:save).and_return(false)
					put :update, {:id => post.to_param, :post => {"title" => "Wrong title"}}
					expect(response).to   render_template("edit")
				end
			end
		end
	end

	describe "DELETE destroy" do
		context "when not signed in" do
			it "it redirects to login path" do
				post = user.posts.create! valid_attributes
				delete :destroy, {:id => post.id} 
				expect(response).to redirect_to(new_user_session_path)
			end

			it "not deletes the post" do
				post = user.posts.create! valid_attributes
				expect {
					delete :destroy, :id => post.to_param
				}.to change(Post, :count).by(0) 
			end
		end

		context "user signed in" do
			before { sign_in user }

			it "destroys the requsted post" do
				post = user.posts.create! valid_attributes
				expect {
					delete :destroy, {:id => post.to_param}
				}.to change(user.posts, :count).by(-1)
			end

			it "redirects to the best posts" do
				post = user.posts.create! valid_attributes
				delete :destroy, {:id => post.to_param}
				expect(response).to   redirect_to(posts_url)
			end
		end
	end

	describe "PATCH karma_up" do
		context "when not signed in" do
			it "it redirects to login path" do
				post = user.posts.create! valid_attributes
				patch :karma_up, {:id => post.id} 
				expect(response).to redirect_to(new_user_session_path)
			end

			it "not change the posts karma" do
				post = user.posts.create! valid_attributes
				expect {
					patch :karma_up, {:id => post.to_param}
				}.to change(post, :cached_votes_total).by(0)
			end
		end

		context "user signed in" do
			before { sign_in user }

			it "change posts karma when user votes" do
				post = user.posts.create! valid_attributes
				patch :karma_up, {:id => post.to_param}
				expect(post.votes_for.size).to eq(1)  
			end
		end
	end

	describe "PATCH karma_down" do
		context "when not signed in" do
			it "it redirects to login path" do
				post = user.posts.create! valid_attributes
				patch :karma_down, {:id => post.to_param}
				expect(response).to redirect_to(new_user_session_path)
			end

			it "not change the posts karma" do
				post = user.posts.create! valid_attributes
				expect {
					patch :karma_down, {:id => post.to_param}
				}.to change(post, :cached_votes_total).by(0)
			end
		end

		context "user signed in" do
			before { sign_in user }

			it "change posts karma when user votes" do
				post = user.posts.create! valid_attributes
				patch :karma_down, {:id => post.to_param}
				patch :karma_down, {:id => post.to_param}
				expect(post.votes_for.size).to eq(0)  
			end
		end
	end
end







