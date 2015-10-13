module Swattr
  class Project < ActiveRecord::Base
    acts_as_paranoid

    # Uploader
    mount_uploader :hero, Swattr::HeroUploader

    # Callbacks
    after_destroy :slug_reset

    # Associations
    belongs_to :author, class_name: Swattr::User
    has_many :issues

    # Validation
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true
    validates :location, url: true, allow_blank: true

    # Default scope
    # default_scope { order(name: :asc, slug: :asc) }

    # Callback methods
    def slug_reset
      update(slug: "#{Time.current.to_i}_#{slug}")
    end

    # Paramater
    def to_param
      slug
    end
  end
end
