class CreateSubreddits < ActiveRecord::Migration[7.0]
  def change
    create_table :subreddits do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
  end
end
