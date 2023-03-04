require 'rails_helper'

RSpec.describe "post_votes/show", type: :view do
  before(:each) do
    @post_vote = assign(:post_vote, PostVote.create!(
      value: false,
      user: nil,
      post: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
