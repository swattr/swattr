module Swattr
  class Comment < ActiveRecord::Base
    acts_as_paranoid

    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :author, class_name: Swattr::User

    # Validation
    validates :issue_id, presence: true
    validates :author_id, presence: true
    validates :body, presence: true

    # Default scope
    default_scope { order(created_at: :asc) }
  end
end
