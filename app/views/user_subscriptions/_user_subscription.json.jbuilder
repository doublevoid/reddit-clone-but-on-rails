json.extract! user_subscription, :id, :created_at, :updated_at
json.url user_subscription_url(user_subscription, format: :json)
