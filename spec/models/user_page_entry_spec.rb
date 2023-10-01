# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPageEntry, type: :model do
  describe '#readonly?' do
    let(:user_page_entry) { described_class.new }

    it 'is a read-only model' do
      expect(user_page_entry).to be_readonly
    end
  end

  describe '.union_query' do
    let(:user) { create(:user, username: 'testuser') }
    let(:user_page_entries) { described_class.union_query(user.username) }
    let(:subreddit) { create(:subreddit, name: 'testsubreddit') }

    before do
      create_list(:post, 3, user:, subreddit:)
      create_list(:comment, 3, user:, post: create(:post, subreddit:))
    end

    it 'returns the correct number of entries' do
      expect(user_page_entries.count).to eq(6)
    end

    context 'for posts' do
      let(:post_entries) { user_page_entries.select { |e| e.entry_type == 'post' } }

      it 'returns the correct number of post entries' do
        expect(post_entries.count).to eq(3)
      end

      it 'returns post details correctly' do
        post = Post.first
        entry = post_entries.find { |e| e.id == post.id }

        expect(entry.username).to eq(user.username)
        expect(entry.post_title).to eq(post.title)
        expect(entry.subreddit_name).to eq(subreddit.name)
      end
    end

    context 'for comments' do
      let(:comment_entries) { user_page_entries.select { |e| e.entry_type == 'comment' } }

      it 'returns the correct number of comment entries' do
        expect(comment_entries.count).to eq(3)
      end

      it 'returns comment details correctly' do
        comment = Comment.first
        entry = comment_entries.find { |e| e.id == comment.id }

        expect(entry.username).to eq(user.username)
        expect(entry.body).to eq(comment.body)
        expect(entry.subreddit_name).to eq(subreddit.name)
      end
    end
  end
end
