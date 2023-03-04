require 'rails_helper'

RSpec.describe "comment_votes/edit", type: :view do
  before(:each) do
    @comment_vote = assign(:comment_vote, CommentVote.create!(
      value: false,
      user: nil,
      comment: nil
    ))
  end

  it "renders the edit comment_vote form" do
    render

    assert_select "form[action=?][method=?]", comment_vote_path(@comment_vote), "post" do

      assert_select "input[name=?]", "comment_vote[value]"

      assert_select "input[name=?]", "comment_vote[user_id]"

      assert_select "input[name=?]", "comment_vote[comment_id]"
    end
  end
end
