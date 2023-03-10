json.extract! vote, :id, :value, :voteable_type, :voteable_id, :user_id, :created_at, :updated_at
json.url vote_url(vote, format: :json)
