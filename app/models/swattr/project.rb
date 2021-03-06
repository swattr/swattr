module Swattr
  class Project < ActiveRecord::Base
    acts_as_paranoid

    # Uploader
    mount_uploader :hero, Swattr::HeroUploader

    # Callbacks
    before_save :slugify_slug
    after_destroy :slug_reset

    # Associations
    belongs_to :author, class_name: Swattr::User
    has_many :issues, dependent: :destroy

    # Validation
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true
    validates :location, url: true, allow_blank: true
    validates :author_id, presence: true

    # Default scope
    # default_scope { order(name: :asc, slug: :asc) }

    # Callback methods
    def slugify_slug
      self.slug = slug.downcase.parameterize
    end

    def slug_reset
      update(slug: "#{Time.current.to_i}_#{slug}")
    end

    # Paramater
    def to_param
      slug
    end
  end
end
