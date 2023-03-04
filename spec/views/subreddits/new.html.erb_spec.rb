require 'rails_helper'

RSpec.describe 'subreddits/new', type: :view do
  before do
    assign(:subreddit, Subreddit.new(
                         name:        'MyString',
                         description: 'MyString'
                       ))
  end

  it 'renders new subreddit form' do
    render

    assert_select 'form[action=?][method=?]', subreddits_path, 'post' do
      assert_select 'input[name=?]', 'subreddit[name]'

      assert_select 'input[name=?]', 'subreddit[description]'
    end
  end
end
