require 'rails_helper'

RSpec.describe "votes/show", type: :view do
  before(:each) do
    @vote = assign(:vote, Vote.create!(
      value: 2,
      voteable_type: "Voteable Type",
      voteable_id: 3,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Voteable Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
