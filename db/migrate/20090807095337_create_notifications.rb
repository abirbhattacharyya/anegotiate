class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.references :user
      t.boolean :point_send
      t.boolean :negotiate
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
