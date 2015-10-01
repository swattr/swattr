class CreateSwattrTasks < ActiveRecord::Migration
  def change
    create_table :swattr_tasks do |t|
      t.string :title
      t.integer :issue_id
      t.integer :author_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
