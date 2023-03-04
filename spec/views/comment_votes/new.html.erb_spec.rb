require 'rails_helper'

RSpec.describe "comment_votes/new", type: :view do
  before(:each) do
    assign(:comment_vote, CommentVote.new(
      value: false,
      user: nil,
      comment: nil
    ))
  end

  it "renders new comment_vote form" do
    render

    assert_select "form[action=?][method=?]", comment_votes_path, "post" do

      assert_select "input[name=?]", "comment_vote[value]"

      assert_select "input[name=?]", "comment_vote[user_id]"

      assert_select "input[name=?]", "comment_vote[comment_id]"
    end
  end
end
