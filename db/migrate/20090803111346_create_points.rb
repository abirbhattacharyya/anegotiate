class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer :sender_user_id
      t.integer :recipient_user_id
      t.integer :point, :limit => 3
      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
