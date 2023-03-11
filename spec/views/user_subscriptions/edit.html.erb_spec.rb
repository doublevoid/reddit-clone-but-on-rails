require 'rails_helper'

RSpec.describe "user_subscriptions/edit", type: :view do
  before(:each) do
    @user_subscription = assign(:user_subscription, UserSubscription.create!())
  end

  it "renders the edit user_subscription form" do
    render

    assert_select "form[action=?][method=?]", user_subscription_path(@user_subscription), "post" do
    end
  end
end
