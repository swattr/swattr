module Swattr
  class User < ActiveRecord::Base
    acts_as_paranoid

    # Callbacks
    after_destroy :email_reset

    # Devise
    devise :database_authenticatable, :registerable, :recoverable, :lockable,
           :rememberable, :trackable, :validatable, :confirmable, :timeoutable,
           :invitable

    # Uploader
    mount_uploader :avatar, Swattr::AvatarUploader

    # Validation
    validates :name, presence: true, allow_blank: true
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, presence: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :create
    validates :password, allow_blank: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :update
    validates :role, presence: true, inclusion: { in: Swattr::ROLES }

    # Default scope
    # default_scope { order(name: :asc, email: :asc) }

    # Callback methods
    def email_reset
      update(email: "#{Time.current.to_i}_#{email}")
    end

    # Methods
    def self.user?
      role?(:user) || !Swattr::ROLES.include?(role.downcase)
    end

    def self.manager?
      role? :manager
    end

    def self.admin?
      role? :admin
    end

    def self.role?(role_type)
      role.downcase == role_type.to_s.downcase
    end
  end
end
