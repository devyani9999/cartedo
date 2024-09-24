class CreateTaskAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :task_assignments do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.integer :assigned_by, class: :user
      t.timestamps
    end
  end
end
