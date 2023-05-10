class UserSubscriptionsController < ApplicationController
  before_action :set_user_subscription, only: %i[destroy]

  # GET /user_subscriptions or /user_subscriptions.json
  def index
    @user_subscriptions = UserSubscription.all
  end

  # POST /user_subscriptions or /user_subscriptions.json
  def create
    @user_subscription = UserSubscription.new(subreddit_id: user_subscription_params[:subreddit_id].to_i,
                                              user_id:      User.last.id)

    respond_to do |format|
      if @user_subscription.save
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
        format.json { render json: @user_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_subscriptions/1 or /user_subscriptions/1.json
  def destroy
    @subreddit = @user_subscription.subreddit
    @user_subscription.destroy

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

  # Use callbacks to share common setup or constraints between actions.
  def set_user_subscription
    @user_subscription = UserSubscription.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_subscription_params
    params.fetch(:user_subscription, {}).permit(:subreddit_id)
  end
end
