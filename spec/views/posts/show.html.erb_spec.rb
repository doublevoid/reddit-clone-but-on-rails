require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  before do
    @post = assign(:post, Post.create!(
                            title:     'Title',
                            body:      'Body',
                            subreddit: nil,
                            user:      nil
                          ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Body/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
