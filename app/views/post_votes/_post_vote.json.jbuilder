json.extract! post_vote, :id, :value, :user_id, :post_id, :created_at, :updated_at
json.url post_vote_url(post_vote, format: :json)
