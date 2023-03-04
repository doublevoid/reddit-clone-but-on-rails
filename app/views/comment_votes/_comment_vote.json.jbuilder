json.extract! comment_vote, :id, :value, :user_id, :comment_id, :created_at, :updated_at
json.url comment_vote_url(comment_vote, format: :json)
