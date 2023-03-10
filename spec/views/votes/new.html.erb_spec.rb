require 'rails_helper'

RSpec.describe "votes/new", type: :view do
  before(:each) do
    assign(:vote, Vote.new(
      value: 1,
      voteable_type: "MyString",
      voteable_id: 1,
      user: nil
    ))
  end

  it "renders new vote form" do
    render

    assert_select "form[action=?][method=?]", votes_path, "post" do

      assert_select "input[name=?]", "vote[value]"

      assert_select "input[name=?]", "vote[voteable_type]"

      assert_select "input[name=?]", "vote[voteable_id]"

      assert_select "input[name=?]", "vote[user_id]"
    end
  end
end
