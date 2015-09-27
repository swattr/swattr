class AddNameToSwattrUsers < ActiveRecord::Migration
  def change
    add_column :swattr_users, :name, :string, default: "", before: :email
  end
end
