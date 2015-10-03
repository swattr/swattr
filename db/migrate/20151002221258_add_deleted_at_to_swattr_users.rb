class AddDeletedAtToSwattrUsers < ActiveRecord::Migration
  def change
    add_column :swattr_users, :deleted_at, :datetime

    add_index :swattr_users, :deleted_at
  end
end
