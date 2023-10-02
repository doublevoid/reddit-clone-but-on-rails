# frozen_string_literal: true

class UserPageService
  attr_reader :user, :data

  def initialize(username)
    @username = username
  end

  def fetch_details
    @user = fetch_user_with_karma
    @data = UserPageEntry.union_query(@username)
  end

  private

  def fetch_user_with_karma
    post_karma = User
                 .joins(posts: :votes)
                 .where(votes: { voteable_type: 'Post' })
                 .group('users.id')
                 .select('users.id, SUM(votes.value) AS post_karma')

    comment_karma = User
                    .joins(comments: :votes)
                    .where(votes: { voteable_type: 'Comment' })
                    .group('users.id')
                    .select('users.id, SUM(votes.value) AS comment_karma')

    User
      .joins("LEFT JOIN (#{post_karma.to_sql}) AS post_karma_sub ON post_karma_sub.id = users.id")
      .joins("LEFT JOIN (#{comment_karma.to_sql}) AS comment_karma_sub ON comment_karma_sub.id = users.id")
      .select('users.*, COALESCE(post_karma_sub.post_karma, 0) AS post_karma, COALESCE(comment_karma_sub.comment_karma, 0) AS comment_karma')
      .where(username: @username)
      .first
  end
end
