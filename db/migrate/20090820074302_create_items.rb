class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string    :name
      t.text      :desc
      t.integer   :points
      t.integer   :cost
      t.integer   :category
      
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
