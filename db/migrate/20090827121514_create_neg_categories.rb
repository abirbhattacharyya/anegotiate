class CreateNegCategories < ActiveRecord::Migration
  def self.up
    create_table :neg_categories do |t|
      t.string :category
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :neg_categories
  end
end
