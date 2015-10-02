module Swattr
  class Tag < ActiveRecord::Base
    # Associations
    has_many :issue_tags
    has_many :issues, through: :issue_tags

    # Validation
    validates :name, presence: true, uniqueness: true
  end
end