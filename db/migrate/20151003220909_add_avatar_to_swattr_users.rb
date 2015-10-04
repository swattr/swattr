class AddAvatarToSwattrUsers < ActiveRecord::Migration
  def change
    add_column :swattr_users, :avatar, :string
  end
end
