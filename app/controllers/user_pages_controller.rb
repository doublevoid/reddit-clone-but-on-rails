class UserPagesController < ApplicationController
  # GET /u/username
  def show
    @user = User.joins(:posts, :comments)
                .joins("JOIN votes AS c_votes on c_votes.voteable_id = comments.id AND c_votes.voteable_type = 'Comment'")
                .joins("JOIN votes AS p_votes on p_votes.voteable_id = posts.id AND p_votes.voteable_type = 'Post'")
                .select('SUM(c_votes.value) AS comment_karma, SUM(p_votes.value) AS post_karma, users.*')
                .group('comments.id, users.id')
                .where(username: params[:id])[0]
    @pagy, @overall = pagy_countless(UserPageEntry.union_query(params[:id]), items: 25)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
