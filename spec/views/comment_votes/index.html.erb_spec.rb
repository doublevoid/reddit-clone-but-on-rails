require 'rails_helper'

RSpec.describe "comment_votes/index", type: :view do
  before(:each) do
    assign(:comment_votes, [
      CommentVote.create!(
        value: false,
        user: nil,
        comment: nil
      ),
      CommentVote.create!(
        value: false,
        user: nil,
        comment: nil
      )
    ])
  end

  it "renders a list of comment_votes" do
    render
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
