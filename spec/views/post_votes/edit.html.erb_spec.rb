require 'rails_helper'

RSpec.describe "post_votes/edit", type: :view do
  before(:each) do
    @post_vote = assign(:post_vote, PostVote.create!(
      value: false,
      user: nil,
      post: nil
    ))
  end

  it "renders the edit post_vote form" do
    render

    assert_select "form[action=?][method=?]", post_vote_path(@post_vote), "post" do

      assert_select "input[name=?]", "post_vote[value]"

      assert_select "input[name=?]", "post_vote[user_id]"

      assert_select "input[name=?]", "post_vote[post_id]"
    end
  end
end
