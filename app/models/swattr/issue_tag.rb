module Swattr
  class IssueTag < ActiveRecord::Base
    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :tag, class_name: Swattr::Tag

    # Validation
    validates :issue_id, presence: true
    validates :tag_id, presence: true
  end
end
