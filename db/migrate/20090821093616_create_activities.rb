class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.references  :user
      t.text        :message
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
