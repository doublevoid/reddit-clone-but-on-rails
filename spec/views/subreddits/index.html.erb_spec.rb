require 'rails_helper'

RSpec.describe 'subreddits/subreddit_posts', type: :view do
  before do
    assign(:subreddits, [
             Subreddit.create!(
               name:        'Name',
               description: 'Description'
             ),
             Subreddit.create!(
               name:        'Name',
               description: 'Description'
             )
           ])
  end

  it 'renders a list of subreddits' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Description'.to_s, count: 2
  end
end
