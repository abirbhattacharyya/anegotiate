class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.references  :user
      t.integer     :friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :friends
  end
end
