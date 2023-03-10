class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.string  :voteable_type
      t.integer :voteable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
