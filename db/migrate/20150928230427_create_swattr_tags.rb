class CreateSwattrTags < ActiveRecord::Migration
  def change
    create_table :swattr_tags do |t|
      t.string :name
      t.string :description
      t.string :color
      t.integer :position

      t.timestamps null: false
    end
  end
end
