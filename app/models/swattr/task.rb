module Swattr
  class Task < ActiveRecord::Base
    # Associations
    belongs_to :issue, class_name: Swattr::Issue
    belongs_to :author, class_name: Swattr::User

    # Validation
    validates :title, presence: true

    # Default scope
    default_scope { order(position: :asc, created_at: :desc) }
  end
end
