module Swattr
  class Priority < ActiveRecord::Base
    # Validation
    validates :name, presence: true

    # Default scope
    # default_scope { order(position: :asc, name: :asc) }
  end
end