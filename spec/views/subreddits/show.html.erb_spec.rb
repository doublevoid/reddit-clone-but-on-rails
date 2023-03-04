require 'rails_helper'

RSpec.describe 'subreddits/show', type: :view do
  before do
    @subreddit = assign(:subreddit, Subreddit.create!(
                                      name:        'Name',
                                      description: 'Description'
                                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
