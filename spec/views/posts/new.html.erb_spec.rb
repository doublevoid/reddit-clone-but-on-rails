require 'rails_helper'

RSpec.describe 'posts/new', type: :view do
  before do
    assign(:post, Post.new(
                    title:     'MyString',
                    body:      'MyString',
                    subreddit: nil,
                    user:      nil
                  ))
  end

  it 'renders new post form' do
    render

    assert_select 'form[action=?][method=?]', posts_path, 'post' do
      assert_select 'input[name=?]', 'post[title]'

      assert_select 'input[name=?]', 'post[body]'

      assert_select 'input[name=?]', 'post[subreddit_id]'

      assert_select 'input[name=?]', 'post[user_id]'
    end
  end
end
