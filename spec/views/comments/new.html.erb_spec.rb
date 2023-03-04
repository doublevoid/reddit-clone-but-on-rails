require 'rails_helper'

RSpec.describe 'comments/new', type: :view do
  before do
    assign(:comment, Comment.new(
                       body: 'MyString',
                       post: nil,
                       user: nil
                     ))
  end

  it 'renders new comment form' do
    render

    assert_select 'form[action=?][method=?]', comments_path, 'post' do
      assert_select 'input[name=?]', 'comment[body]'

      assert_select 'input[name=?]', 'comment[post_id]'

      assert_select 'input[name=?]', 'comment[user_id]'
    end
  end
end
