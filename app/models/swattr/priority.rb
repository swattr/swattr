module Swattr
  class Priority < ActiveRecord::Base
    # Callbacks
    before_create :set_default_position

    # Validation
    validates :name, presence: true

    # Default scope
    # default_scope { order(position: :asc, name: :asc) }

    # Callback methods
    def set_default_position
      self.position = Priority.count
    end
  end
end
