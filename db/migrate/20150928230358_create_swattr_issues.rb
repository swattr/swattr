class CreateSwattrIssues < ActiveRecord::Migration
  def change
    create_table :swattr_issues do |t|
      t.string :title
      t.text :content
      t.integer :project_id
      t.integer :author_id
      t.integer :assignee_id
      t.integer :priority_id
      t.integer :status_id
      t.integer :resolution_id
      t.datetime :due_at

      t.timestamps null: false
    end
  end
end
