require 'rails_helper'

RSpec.describe 'user_subscriptions/show', type: :view do
  before do
    @user_subscription = assign(:user_subscription, UserSubscription.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
