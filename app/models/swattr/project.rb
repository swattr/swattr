module Swattr
  class Project < ActiveRecord::Base
    acts_as_paranoid

    # Associations
    belongs_to :author, class_name: Swattr::User
    belongs_to :owner, class_name: Swattr::User
    has_many :issues

    # Validation
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true
    validates :location, url: true, allow_blank: true

    # Default scope
    # default_scope { order(name: :asc, slug: :asc) }
  end
end
