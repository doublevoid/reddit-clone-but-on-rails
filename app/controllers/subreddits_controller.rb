class SubredditsController < ApplicationController
  before_action :set_subreddit, only: %i[edit update destroy]

  # GET /subreddits or /subreddits.json
  def index
    @subreddits = Subreddit.all
  end

  # GET /r/1 or /r/1.json
  def show
    @pagy, @posts = pagy_countless(Post.eager_load(:comments, :votes, :subreddit, :user)
                                       .select('sum(votes.value) as karma, posts.*')
                                       .where('subreddits.name = ?', params[:subreddit_name])
                                       .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
                                       .order('sum(votes.value) asc, count(comments) desc, title asc'), items: 25)
    @subreddit = Subreddit.eager_load(:user_subscriptions)
                          .where(name: params[:subreddit_name])
                          .where('user_subscriptions.user_id =? OR user_subscriptions.user_id IS NULL', 1)[0]
  end

  # GET /r/all
  def all
    @subreddit_name = 'all'
    @pagy, @posts = pagy_countless(Post.eager_load(:comments, :votes, :subreddit, :user)
                                       .select('sum(votes.value) as karma, posts.*')
                                       .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
                                       .order('sum(votes.value) asc, count(comments) desc, title asc'), items: 50)
  end

  # GET /
  def frontpage
    @subreddit_name = ''
    @pagy, @posts = pagy_countless(Post.eager_load(:comments, :votes, :subreddit, :user)
                                      .select('sum(votes.value) as karma, posts.*')
                                      .where('posts.subreddit_id': UserSubscription.where(user: current_user).map(&:subreddit_id))
                                      .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
                                      .order('sum(votes.value) asc, count(comments) desc, title asc'), items: 50)
    # debugger
  end

  # GET /subreddits/new
  def new
    @subreddit = Subreddit.new
  end

  # GET /subreddits/1/edit
  def edit; end

  # POST /subreddits or /subreddits.json
  def create
    @subreddit = Subreddit.new(subreddit_params)

    respond_to do |format|
      if @subreddit.save
        format.html { redirect_to subreddit_url(@subreddit), notice: 'Subreddit was successfully created.' }
        format.json { render :show, status: :created, location: @subreddit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subreddits/1 or /subreddits/1.json
  def update
    respond_to do |format|
      if @subreddit.update(subreddit_params)
        format.html { redirect_to subreddit_url(@subreddit), notice: 'Subreddit was successfully updated.' }
        format.json { render :show, status: :ok, location: @subreddit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subreddit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subreddits/1 or /subreddits/1.json
  def destroy
    @subreddit.destroy

    respond_to do |format|
      format.html { redirect_to subreddits_url, notice: 'Subreddit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subreddit
    @subreddit = Subreddit.find(params[:subreddit_name])
  end

  # Only allow a list of trusted parameters through.
  def subreddit_params
    params.require(:subreddit).permit(:name, :description)
  end
end
