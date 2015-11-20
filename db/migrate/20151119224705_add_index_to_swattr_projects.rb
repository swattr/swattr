class AddIndexToSwattrProjects < ActiveRecord::Migration
  def change
    add_index :swattr_projects, :slug, unique: true
  end
end
