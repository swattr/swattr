module Swattr
  class Resolution < ActiveRecord::Base
    # Callbacks
    before_create :set_default_position

    # Validation
    validates :name, presence: true

    # Default scope
    # default_scope { order(position: :asc, name: :asc) }

    # Callback methods
    def set_default_position
      self.position = Resolution.count
    end
  end
end
