class CreateCompletedTasks < ActiveRecord::Migration
  def self.up
    create_table :completed_tasks do |t|
      t.references  :user
      t.references  :task
      
      t.timestamps
    end
  end

  def self.down
    drop_table :completed_tasks
  end
end
