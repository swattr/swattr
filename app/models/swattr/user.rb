module Swattr
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :recoverable, :lockable,
           :rememberable, :trackable, :validatable, :confirmable, :timeoutable

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
    default_scope { order(name: :asc, email: :asc) }
  end
end
