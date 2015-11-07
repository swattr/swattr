class CreateSwattrComments < ActiveRecord::Migration
  def change
    create_table :swattr_comments do |t|
      t.integer :author_id
      t.integer :issue_id
      t.text :body
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :swattr_comments, :deleted_at
  end
end
