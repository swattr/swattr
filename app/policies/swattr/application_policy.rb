module Swattr
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user   = user
      @record = record
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?
      true
    end

    def new?
      create?
    end

    def update?
      true
    end

    def edit?
      update?
    end

    def destroy?
      true
    end

    protected

    def has_management_role?
      user.manager? || user.admin?
    end
  end
end
