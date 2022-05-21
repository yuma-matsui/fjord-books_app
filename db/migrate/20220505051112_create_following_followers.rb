class CreateFollowingFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :following_followers do |t|
      t.integer :followed_id, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end
    add_index :following_followers, :follower_id
    add_index :following_followers, :followed_id
    add_index :following_followers, [:follower_id, :followed_id], unique: true
  end
end
