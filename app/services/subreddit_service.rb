# frozen_string_literal: true
class SubredditService
  def self.find_posts_for_subreddit(subreddit_name)
    Post.eager_load(:comments, :votes, :subreddit, :user)
        .select('sum(votes.value) as karma, posts.*')
        .where('subreddits.name = ?', subreddit_name)
        .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
        .order('sum(votes.value) asc, count(comments) desc, title asc')
  end

  def self.find_posts_for_all
    Post.eager_load(:comments, :votes, :subreddit, :user)
        .select('sum(votes.value) as karma, posts.*')
        .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
        .order('sum(votes.value) asc, count(comments) desc, title asc')
  end

  def self.find_frontpage_posts(user)
    Post.eager_load(:comments, :votes, :subreddit, :user)
        .select('sum(votes.value) as karma, posts.*')
        .where('posts.subreddit_id': UserSubscription.where(user: user).map(&:subreddit_id))
        .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
        .order('sum(votes.value) asc, count(comments) desc, title asc')
  end

  def self.create_subreddit(params)
    subreddit = Subreddit.new(params)
    if subreddit.save
      return [true, subreddit]
    else
      return [false, subreddit.errors]
    end
  end

  def self.update_subreddit(subreddit, params)
    if subreddit.update(params)
      return [true, subreddit]
    else
      return [false, subreddit.errors]
    end
  end

  def self.destroy_subreddit(subreddit)
    subreddit.destroy
  end
end
