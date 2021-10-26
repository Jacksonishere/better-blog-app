class PostsController < ApplicationController
  before_action :require_current_user
  #call set_posts which will find the post for the current post/:id
  #allow user to show other posts
  before_action :set_post, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    # @posts = Post.all
    # we want to scope the posts to the current user only
    @posts = current_user.posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    # with assocations, you can build through the association
    # @post = Post.new(post_params)
    #@post.user_id = current_user.id

    #this inherently takes the current_user's PK and store it in the FK of the new post because of the assocation we set. It essentially creates this new posts and associates the post with the user.
    # @post = current_user.posts.new(post_params)
    @post = current_user.posts.build(post_params)


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Using this, a user cannot access or edit another user's posts, since it the controller cannot even fire off the action that will show/update/destory another user's posts. 
    # This is because before any of those actions even fire off, we need to look for the post that belongs to the other user, and not the current_user. 
    # When we run the current_user.posts.find query, it will not be successful because another users posts ID cannot possibly belong here. 
    def set_post
      # @post = Post.find(params[:id])
      # want to scope posts to user. 
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description)
    end
end
