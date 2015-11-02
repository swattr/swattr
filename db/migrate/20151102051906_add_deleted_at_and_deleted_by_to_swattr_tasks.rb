class AddDeletedAtAndDeletedByToSwattrTasks < ActiveRecord::Migration
  def change
    add_column :swattr_tasks, :deleted_at, :datetime
    add_column :swattr_tasks, :deleted_by, :integer

    add_index :swattr_tasks, :deleted_at
  end
end
