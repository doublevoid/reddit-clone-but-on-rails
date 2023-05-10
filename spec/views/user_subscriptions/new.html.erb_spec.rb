require 'rails_helper'

RSpec.describe 'user_subscriptions/new', type: :view do
  before do
    assign(:user_subscription, UserSubscription.new)
  end

  it 'renders new user_subscription form' do
    render

    assert_select 'form[action=?][method=?]', user_subscriptions_path, 'post' do
    end
  end
end
