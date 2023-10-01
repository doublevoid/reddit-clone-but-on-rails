class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def subreddit_posts
    @pagy, @posts = pagy_countless(PostService.find_posts_for_subreddit, items: 25)
  end

  def show
    @post, @comments = PostService.find_post_and_comments_by_id(params[:id])
    @pagy, @comments = pagy_countless(@comments, items: 25)
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    success, result = PostService.create_post(post_params)
    respond_to do |format|
      if success
        @post = result
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def update
    success, result = PostService.update_post(@post, post_params)
    respond_to do |format|
      if success
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    PostService.destroy_post(@post)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :subreddit_id, :user_id)
  end
end
