class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string    :name
      t.text      :description
      t.integer   :energy
      t.integer   :risk
      t.integer   :point
      t.string    :category
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
