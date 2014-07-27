class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :karma_up, :karma_down]
	before_action :set_post, only: [:show, :edit, :update, :destroy, :karma_up, :karma_down]

	def best
		@posts = Post.order(:cached_votes_total => :desc).paginate(:page => params[:page], :per_page => 7)
	end

  def fresh
    @posts = Post.order(created_at: :desc).paginate(:page => params[:page], :per_page => 7)
  end

	def show
	end

	def new
		@post = current_user.posts.new
	end

	def edit
	end

	def create
		@post = current_user.posts.new(post_params)

		respond_to do |format|
    		if @post.save
        		format.html { redirect_to @post, notice: 'Article was successfully created.' }
        		format.json { render :show, status: :created, location: @post }
      		else
        		format.html { render :new }
        		format.json { render json: @post.errors, status: :unprocessable_entity }
      		end
    	end
	end

	def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def karma_up
    @post.liked_by current_user

    respond_to do |format|
      format.html { redirect_to @post, notice: "Thank you #{current_user.name.capitalize} for voting up!" }
      format.js {}
    end
  end

  def karma_down
    @post.unliked_by current_user
  end

  private

  	def set_post
      	@post = Post.find_by_slug(params[:id])
    end

    def post_params
    	params[:post].permit(:title, :body)
    end
end
