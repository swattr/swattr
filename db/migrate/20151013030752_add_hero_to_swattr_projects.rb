class AddHeroToSwattrProjects < ActiveRecord::Migration
  def change
    add_column :swattr_projects, :hero, :string
  end
end
