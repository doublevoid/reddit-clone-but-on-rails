require 'rails_helper'

RSpec.describe "comment_votes/show", type: :view do
  before(:each) do
    @comment_vote = assign(:comment_vote, CommentVote.create!(
      value: false,
      user: nil,
      comment: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
