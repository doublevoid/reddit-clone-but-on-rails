require 'rails_helper'

RSpec.describe SubredditsController, type: :routing do
  describe 'routing' do
    it 'routes to #subreddit_posts' do
      expect(get: '/subreddits').to route_to('subreddits#index')
    end

    it 'routes to #new' do
      expect(get: '/subreddits/new').to route_to('subreddits#new')
    end

    it 'routes to #show' do
      expect(get: '/subreddits/1').to route_to('subreddits#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/subreddits/1/edit').to route_to('subreddits#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/subreddits').to route_to('subreddits#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/subreddits/1').to route_to('subreddits#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/subreddits/1').to route_to('subreddits#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/subreddits/1').to route_to('subreddits#destroy', id: '1')
    end
  end
end
