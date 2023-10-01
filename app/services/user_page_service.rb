# frozen_string_literal: true

class UserPageService
  include Pagy::Backend
  attr_reader :user, :pagy, :overall, :username

  def initialize(username)
    @username = username
  end

  def fetch_details
    @user = fetch_user_with_karma
  end

  private

  def fetch_user_with_karma
    User.joins(:posts, :comments)
        .joins("JOIN votes AS c_votes on c_votes.voteable_id = comments.id AND c_votes.voteable_type = 'Comment'")
        .joins("JOIN votes AS p_votes on p_votes.voteable_id = posts.id AND p_votes.voteable_type = 'Post'")
        .select('SUM(c_votes.value) AS comment_karma, SUM(p_votes.value) AS post_karma, users.*')
        .group('comments.id, users.id')
        .where(username: @username)[0]
  end
end
