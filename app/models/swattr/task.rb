module Swattr
  class Task < ActiveRecord::Base
    # Callbacks
    before_create :set_default_position

    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :author, class_name: Swattr::User

    # Validation
    validates :title, presence: true
    validates :issue_id, presence: true
    validates :author_id, presence: true

    # Default scope
    # default_scope { order(position: :asc, created_at: :desc) }

    # Callback methods
    def set_default_position
      self.position = Task.count
    end
  end
end
