class CreateAttemptedTasks < ActiveRecord::Migration
  def self.up
    create_table :attempted_tasks do |t|
      t.references  :user
      t.references  :task
      t.integer     :counter, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :attempted_tasks
  end
end
