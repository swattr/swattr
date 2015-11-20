module Swattr
  class Tag < ActiveRecord::Base
    # Callbacks
    before_create :set_default_position

    # Associations
    has_many :issue_tags
    has_many :issues, through: :issue_tags

    # Validation
    validates :name, presence: true, uniqueness: true
    validates :slug, presence: true, uniqueness: true

    # Callback methods
    def set_default_position
      self.position = Tag.count
    end
  end
end
