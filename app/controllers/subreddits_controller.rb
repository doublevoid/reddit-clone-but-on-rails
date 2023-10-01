class SubredditsController < ApplicationController
  before_action :set_subreddit, only: %i[edit update destroy]

  def index
    @subreddits = Subreddit.all
  end

  def show
    @pagy, @posts = pagy_countless(SubredditService.find_posts_for_subreddit(params[:subreddit_name]), items: 25)
    @subreddit = Subreddit.eager_load(:user_subscriptions)
                          .where(name: params[:subreddit_name])
                          .where('user_subscriptions.user_id =? OR user_subscriptions.user_id IS NULL', 1)[0]
  end

  def all
    @subreddit_name = 'all'
    @pagy, @posts = pagy_countless(SubredditService.find_posts_for_all, items: 50)
  end

  def frontpage
    @subreddit_name = ''
    @pagy, @posts = pagy_countless(SubredditService.find_frontpage_posts(current_user), items: 50)
  end

  def new
    @subreddit = Subreddit.new
  end

  def edit; end

  def create
    success, result = SubredditService.create_subreddit(subreddit_params)
    respond_to do |format|
      if success
        @subreddit = result
        format.html { redirect_to subreddit_url(@subreddit), notice: 'Subreddit was successfully created.' }
        format.json { render :show, status: :created, location: @subreddit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def update
    success, result = SubredditService.update_subreddit(@subreddit, subreddit_params)
    respond_to do |format|
      if success
        format.html { redirect_to subreddit_url(@subreddit), notice: 'Subreddit was successfully updated.' }
        format.json { render :show, status: :ok, location: @subreddit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    SubredditService.destroy_subreddit(@subreddit)
    respond_to do |format|
      format.html { redirect_to subreddits_url, notice: 'Subreddit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_subreddit
    @subreddit = Subreddit.find(params[:subreddit_name])
  end

  def subreddit_params
    params.require(:subreddit).permit(:name, :description)
  end
end
