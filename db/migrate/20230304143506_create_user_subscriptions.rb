class CreateUserSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subreddit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
