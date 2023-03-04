class CreatePostVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_votes do |t|
      t.integer :value, default: 1, null: false
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
