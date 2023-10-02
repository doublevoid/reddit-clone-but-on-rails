# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPageService do
  describe '#fetch_details' do
    subject { described_class.new(username) }

    let(:username) { 'testuser' }
    let!(:user) { create(:user, username:) }
    let(:subreddit) { create(:subreddit) }

    before do
      3.times do
        post = create(:post, user:, subreddit:)
        create(:comment, user:, post:)
      end
    end

    it 'fetches the user with correct karma' do
      subject.fetch_details
      fetched_user = subject.user

      expect(fetched_user.comment_karma).to eq(3)
      expect(fetched_user.post_karma).to eq(3)
    end

    it 'fetches the user page entry data' do
      subject.fetch_details
      fetched_data = subject.instance_variable_get(:@data)

      expect(fetched_data).not_to be_empty
    end
  end
end
