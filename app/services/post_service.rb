# frozen_string_literal: true
class PostService
  def self.find_posts_for_subreddit
    Post.eager_load(:comments, :votes, :subreddit, :user)
        .select('sum(votes.value) as karma, posts.*')
        .group('posts.id, comments.id, subreddits.id, votes.id, users.id')
        .order('sum(votes.value) asc')
  end

  def self.find_post_and_comments_by_id(id)
    post = Post.eager_load(:votes, :subreddit, :user, :comments)
               .select('sum(votes.value) as karma, posts.*')
               .where(id: id)
               .group('posts.id, subreddits.id, votes.id, users.id, comments.id')
               .order('sum(votes.value) asc')[0]
    comments = post.comments.eager_load(:user, :votes)
                   .select('sum(votes.value) as karma, comments.*')
                   .group('comments.id, users.id, votes.id')
                   .order('sum(votes.value) asc')
    return post, comments
  end

  def self.create_post(params)
    post = Post.new(params)
    debugger
    if post.save
      [true, post]
    else
      [false, post.errors]
    end
  end

  def self.update_post(post, params)
    if post.update(params)
      [true, post]
    else
      [false, post.errors]
    end
  end

  def self.destroy_post(post)
    post.destroy
  end
end
