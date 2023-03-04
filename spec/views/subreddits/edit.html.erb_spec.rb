require 'rails_helper'

RSpec.describe 'subreddits/edit', type: :view do
  before do
    @subreddit = assign(:subreddit, Subreddit.create!(
                                      name:        'MyString',
                                      description: 'MyString'
                                    ))
  end

  it 'renders the edit subreddit form' do
    render

    assert_select 'form[action=?][method=?]', subreddit_path(@subreddit), 'post' do
      assert_select 'input[name=?]', 'subreddit[name]'

      assert_select 'input[name=?]', 'subreddit[description]'
    end
  end
end
