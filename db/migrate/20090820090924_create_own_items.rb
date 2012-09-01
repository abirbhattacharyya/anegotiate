class CreateOwnItems < ActiveRecord::Migration
  def self.up
    create_table :own_items do |t|
      t.references  :user
      t.references  :item
      t.integer     :qty
      
      t.timestamps
    end
  end

  def self.down
    drop_table :own_items
  end
end
