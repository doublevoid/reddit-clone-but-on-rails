require 'rails_helper'

RSpec.describe "post_votes/index", type: :view do
  before(:each) do
    assign(:post_votes, [
      PostVote.create!(
        value: false,
        user: nil,
        post: nil
      ),
      PostVote.create!(
        value: false,
        user: nil,
        post: nil
      )
    ])
  end

  it "renders a list of post_votes" do
    render
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
