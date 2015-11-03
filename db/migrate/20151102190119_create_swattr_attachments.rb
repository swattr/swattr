class CreateSwattrAttachments < ActiveRecord::Migration
  def change
    create_table :swattr_attachments do |t|
      t.integer :issue_id
      t.integer :uploader_id
      t.string :title
      t.string :description
      t.string :source

      t.timestamps null: false
    end
  end
end
