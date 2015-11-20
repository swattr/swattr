class AddSlugToSwattrTags < ActiveRecord::Migration
  def change
    add_column :swattr_tags, :slug, :string

    add_index :swattr_tags, :slug, unique: true
  end
end
