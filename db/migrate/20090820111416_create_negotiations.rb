class CreateNegotiations < ActiveRecord::Migration
  def self.up
    create_table :negotiations do |t|
      t.references  :user
      t.integer      :negotiate_with
      t.integer     :won_points
      t.integer     :lost_points
      t.timestamps
    end
  end

  def self.down
    drop_table :negotiations
  end
end
