class UserPagesController < ApplicationController
  # GET /u/username
  def show
    @user = User.joins(:posts, :comments)
                .joins("JOIN votes AS c_votes on c_votes.voteable_id = comments.id AND c_votes.voteable_type = 'Comment'")
                .joins("JOIN votes AS p_votes on p_votes.voteable_id = posts.id AND p_votes.voteable_type = 'Post'")
                .select('SUM(c_votes.value) AS comment_karma, SUM(p_votes.value) AS post_karma, users.*')
                .group('comments.id, users.id')
                .where(username: params[:id])[0]

    everything = @user.posts
                      .eager_load(:comments, :subreddit)
                      .left_joins(:user)
                      .joins("LEFT JOIN votes on votes.voteable_type = 'Post' AND votes.voteable_id = posts.id")
                      .select('sum(votes.value) as karma, posts.*')
                      .group('posts.id, votes.id, comments.id, subreddits.id')
                      .where('users.username = ?', params[:id]) +
                 @user.comments
                      .eager_load(post: [:subreddit])
                      .left_joins(:user)
                      .joins("LEFT JOIN votes on votes.voteable_type = 'Comment' AND votes.voteable_id = comments.id")
                      .select('sum(votes.value) as karma, comments.*')
                      .group('comments.id, votes.id, posts.id, subreddits.id')
                      .where('users.username = ?', params[:id])

    @pagy, @overall = pagy_array(everything.sort_by(&:created_at).reverse, items: 50)
  end
end
