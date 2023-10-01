class UserSubscriptionsController < ApplicationController
  before_action :set_user_subscription, only: %i[destroy]

  def index
    @user_subscriptions = UserSubscription.all
  end

  def create
    subscription_service = UserSubscriptionService.new(user_subscription_params[:subreddit_id].to_i)
    respond_to do |format|
      if subscription_service.create
        @user_subscription = subscription_service.user_subscription
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@user_subscription.subreddit),
                                                    partial: 'shared/unsubscribe_button',
                                                    locals:  { subscription: @user_subscription })
        end
        format.html do
          redirect_to subreddit_path(@user_subscription.subreddit.name),
                      notice: 'User subscription was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: subscription_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subreddit = UserSubscriptionService.new(nil).destroy(@user_subscription)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(ActionView::RecordIdentifier.dom_id(@user_subscription),
                                                  partial: 'shared/subscribe_button')
      end
      format.html { redirect_to user_subscriptions_url, notice: 'User subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user_subscription
    @user_subscription = UserSubscription.find(params[:id])
  end

  def user_subscription_params
    params.fetch(:user_subscription, {}).permit(:subreddit_id)
  end
end
