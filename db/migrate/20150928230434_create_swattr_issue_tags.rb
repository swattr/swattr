class CreateSwattrIssueTags < ActiveRecord::Migration
  def change
    create_table :swattr_issue_tags do |t|
      t.integer :issue_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
