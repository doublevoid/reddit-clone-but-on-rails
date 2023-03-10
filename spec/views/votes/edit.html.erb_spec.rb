require 'rails_helper'

RSpec.describe "votes/edit", type: :view do
  before(:each) do
    @vote = assign(:vote, Vote.create!(
      value: 1,
      voteable_type: "MyString",
      voteable_id: 1,
      user: nil
    ))
  end

  it "renders the edit vote form" do
    render

    assert_select "form[action=?][method=?]", vote_path(@vote), "post" do

      assert_select "input[name=?]", "vote[value]"

      assert_select "input[name=?]", "vote[voteable_type]"

      assert_select "input[name=?]", "vote[voteable_id]"

      assert_select "input[name=?]", "vote[user_id]"
    end
  end
end
