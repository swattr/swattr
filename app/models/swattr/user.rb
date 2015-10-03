module Swattr
  class User < ActiveRecord::Base
    acts_as_paranoid

    after_destroy :email_reset

    devise :database_authenticatable, :registerable, :recoverable, :lockable,
           :rememberable, :trackable, :validatable, :confirmable, :timeoutable,
           :invitable

    # Validation
    validates :name, presence: true, allow_blank: true
    validates :email, presence: true, uniqueness: true, email: true
    validates :password, presence: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :create
    validates :password, allow_blank: true,
                         length: { minimum: 5, maximum: 120 },
                         on: :update

    # Default scope
    # default_scope { order(name: :asc, email: :asc) }

    # Callbacks
    def email_reset
      update(email: "#{Time.current.to_i}_#{email}")
    end
  end
end
