require 'rails_helper'

RSpec.describe 'comments/show', type: :view do
  before do
    @comment = assign(:comment, Comment.create!(
                                  body: 'Body',
                                  post: nil,
                                  user: nil
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Body/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
