json.extract! subreddit, :id, :name, :description, :created_at, :updated_at
json.url subreddit_url(subreddit, format: :json)
