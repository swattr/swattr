class AddDeletedAtToSwattrIssues < ActiveRecord::Migration
  def change
    add_column :swattr_issues, :deleted_at, :datetime

    add_index :swattr_issues, :deleted_at
  end
end
