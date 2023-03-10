class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def subreddit_posts
    @pagy, @posts = pagy_countless(Post.eager_load(:comments, :votes, :subreddit, :user)
                                       .select('sum(votes.value) as karma, posts.*')
                                       .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
                                       .order('sum(votes.value) asc'), items: 25)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.eager_load(:votes, :subreddit, :user, :comments)
                .select('sum(votes.value) as karma, posts.*')
                .where(id: params[:id])
                .group('posts.id, subreddits.id, votes.id, users.id, comments.id')
                .order('sum(votes.value) asc')[0]

    @pagy, @comments = pagy_countless(@post.comments.eager_load(:user, :votes)
                                           .select('sum(votes.value) as karma, comments.*')
                                           .group('comments.id, users.id, votes.id')
                                           .order('sum(votes.value) asc'), items: 25)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
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
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :subreddit_id, :user_id)
  end
end
