require 'rails_helper'

RSpec.describe 'comments/subreddit_posts', type: :view do
  before do
    assign(:comments, [
             Comment.create!(
               body: 'Body',
               post: nil,
               user: nil
             ),
             Comment.create!(
               body: 'Body',
               post: nil,
               user: nil
             )
           ])
  end

  it 'renders a list of comments' do
    render
    assert_select 'tr>td', text: 'Body'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
