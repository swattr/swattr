module Swattr
  class IssueTag < ActiveRecord::Base
    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :tag, class_name: Swattr::Tag
  end
end
