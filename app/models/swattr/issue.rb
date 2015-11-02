module Swattr
  class Issue < ActiveRecord::Base
    acts_as_paranoid

    # Associations
    belongs_to :project, class_name: Swattr::Project
    belongs_to :author, class_name: Swattr::User
    belongs_to :assignee, class_name: Swattr::User
    belongs_to :priority, class_name: Swattr::Priority
    belongs_to :status, class_name: Swattr::Status
    belongs_to :resolution, class_name: Swattr::Resolution
    has_many :tasks
    has_many :issue_tags
    has_many :tags, through: :issue_tags

    # Nested attributes
    accepts_nested_attributes_for :tags

    # Validation
    validates :title, presence: true
    validates :content, presence: true
    validates :project_id, presence: true
    validates :author_id, presence: true
    validates :due_at, date: { allow_blank: true }

    # Default scope
    # default_scope { order(created_at: :desc) }
  end
end
