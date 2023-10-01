# frozen_string_literal: true

class UserPageEntry < ApplicationRecord
  self.table_name = 'votes'
  attribute :id, :integer
  attribute :entry_type, :string
  attribute :created_at, :date
  attribute :karma, :integer
  attribute :comment_count, :integer
  attribute :username, :string
  attribute :post_title, :string
  attribute :body, :string
  attribute :subreddit_name, :string
  attribute :post_id, :integer

  def readonly?
    true
  end

  class << self
    def union_query(user_id, *_args)
      query = Arel::Nodes::As.new(
        Arel::Nodes::UnionAll.new(
          posts_query(user_id),
          comments_query(user_id)
        ),
        Vote.arel_table
      )
      UserPageEntry.from(query).order(created_at: :desc)
    end

    private

    def posts_query(user_id)
      Post
        .joins(:subreddit)
        .joins(:user)
        .joins(:comments)
        .joins("LEFT JOIN votes on votes.voteable_type = 'Comment' AND votes.voteable_id = comments.id")
        .select("posts.id, 'post' as entry_type, posts.created_at, sum(votes.value) as karma, count(comments.id) AS
                    comment_count, users.username AS username, posts.title AS post_title, posts.body,
                           subreddits.name as subreddit_name, null as post_id")
        .group('comments.id, votes.id, posts.id, users.id, subreddits.id')
        .where('users.username = ?', user_id).arel
    end

    def comments_query(user_id)
      Comment
        .joins(post: [:subreddit])
        .joins(:user)
        .joins(:post)
        .joins("LEFT JOIN votes on votes.voteable_type = 'Comment' AND votes.voteable_id = comments.id")
        .select("posts.id, 'comment' as entry_type, comments.created_at, sum(votes.value) as karma, null AS
                    comment_count, users.username AS username, posts.title AS post_title, comments.body,
                           subreddits.name as subreddit_name, posts.id as post_id")
        .group('comments.id, votes.id, posts.id, users.id, subreddits.id')
        .where('users.username = ?', user_id).arel
    end
  end
end
