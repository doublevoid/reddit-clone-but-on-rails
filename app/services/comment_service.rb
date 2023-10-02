class CommentService
  def self.all_comments
    Comment.all
  end

  def self.find_comment_by_id(id)
    Comment.find(id)
  end

  def self.create_comment(params)
    comment = Comment.new(params)
    if comment.save
      [true, comment]
    else
      [false, comment.errors]
    end
  end

  def self.update_comment(comment, params)
    if comment.update(params)
      [true, comment]
    else
      [false, comment.errors]
    end
  end

  def self.destroy_comment(comment)
    comment.destroy
  end
end
