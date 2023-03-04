require 'rails_helper'

RSpec.describe "post_votes/new", type: :view do
  before(:each) do
    assign(:post_vote, PostVote.new(
      value: false,
      user: nil,
      post: nil
    ))
  end

  it "renders new post_vote form" do
    render

    assert_select "form[action=?][method=?]", post_votes_path, "post" do

      assert_select "input[name=?]", "post_vote[value]"

      assert_select "input[name=?]", "post_vote[user_id]"

      assert_select "input[name=?]", "post_vote[post_id]"
    end
  end
end
