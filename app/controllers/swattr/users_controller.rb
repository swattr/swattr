module Swattr
  class UsersController < ApplicationController
    include Swattr::Concern::Resourceful

    def index
      @q = Swattr::User.ransack(params[:q].try(:merge, m: "or"))

      @users = @q.result(distinct: true).page(params[:page]).per(per_page)

      authorize @users

      respond_with @users
    end

    def create
      authorize @user

      @user = Swattr::User.invite!(resource_params)

      respond_with @user, location: -> { location_after_create }
    end

    def update
      authorize @user

      @user.update_without_password(resource_params)

      respond_with @user, location: -> { location_after_update }
    end

    protected

    def location_after_save
      users_path
    end

    def permitted_attributes
      [
        :name, :email, :remove_avatar
      ]
    end
  end
end
