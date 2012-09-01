class CreateLotteries < ActiveRecord::Migration
  def self.up
    create_table :lotteries do |t|
      t.references  :user
      
      t.integer     :points
      t.integer     :won_points
      t.integer     :lose_points
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lotteries
  end
end
