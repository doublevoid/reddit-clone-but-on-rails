require 'rails_helper'

RSpec.describe 'user_subscriptions/index', type: :view do
  before do
    assign(:user_subscriptions, [
             UserSubscription.create!,
             UserSubscription.create!
           ])
  end

  it 'renders a list of user_subscriptions' do
    render
  end
end
