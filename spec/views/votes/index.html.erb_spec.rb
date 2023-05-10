require 'rails_helper'

RSpec.describe 'votes/subreddit_posts', type: :view do
  before do
    assign(:votes, [
             Vote.create!(
               value:         2,
               voteable_type: 'Voteable Type',
               voteable_id:   3,
               user:          nil
             ),
             Vote.create!(
               value:         2,
               voteable_type: 'Voteable Type',
               voteable_id:   3,
               user:          nil
             )
           ])
  end

  it 'renders a list of votes' do
    render
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 'Voteable Type'.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
