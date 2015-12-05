module Swattr
  class Attachment < ActiveRecord::Base
    # Uploader
    mount_uploader :source, Swattr::SourceUploader

    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :uploader, class_name: Swattr::User

    # Validation
    validates :source, presence: true, file_size: {
      less_than_or_equal_to: Swattr.configuration.attachment_maximum_file_size
    }
    validates :issue_id, presence: true
    validates :uploader_id, presence: true

    # Default scope
    default_scope { order(created_at: :asc) }
  end
end
