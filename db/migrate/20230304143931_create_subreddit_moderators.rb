class CreateSubredditModerators < ActiveRecord::Migration[7.0]
  def change
    create_table :subreddit_moderators do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subreddit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
