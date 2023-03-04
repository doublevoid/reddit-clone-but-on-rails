require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before do
    assign(:posts, [
             Post.create!(
               title:     'Title',
               body:      'Body',
               subreddit: nil,
               user:      nil
             ),
             Post.create!(
               title:     'Title',
               body:      'Body',
               subreddit: nil,
               user:      nil
             )
           ])
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
    assert_select 'tr>td', text: 'Body'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
