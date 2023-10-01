class UserSubscriptionService
  attr_reader :user_subscription, :errors

  def initialize(subreddit_id, user_id = User.last.id)
    @user_subscription = UserSubscription.create(subreddit_id:, user_id:)
    @errors = []
  end

  def create
    if @user_subscription.save
      true
    else
      @errors = @user_subscription.errors
      false
    end
  end

  def destroy(user_subscription)
    subreddit = user_subscription.subreddit
    user_subscription.destroy
    subreddit
  end
end
