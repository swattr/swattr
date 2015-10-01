class CreateSwattrProjects < ActiveRecord::Migration
  def change
    create_table :swattr_projects do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.string :location
      t.integer :author_id
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
