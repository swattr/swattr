module Swattr
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = Swattr::User.page(params[:page]).per(per_page)

      respond_with @users
    end

    def show
      respond_with @user
    end

    def new
      @user = Swattr::User.new

      respond_with @user
    end

    def edit
      respond_with @user
    end

    def create
      # TODO: Off the beaten path. Send custom flash message saying the userwas invited.
      @user = Swattr::User.invite!(user_params)

      respond_with @user, location: -> { users_path }
    end

    def update
      @user.update_without_password(user_params)

      respond_with @user, location: -> { user_path(@user) }
    end

    def destroy
      @user.destroy

      respond_with @user, location: -> { users_path }
    end

    protected

    def permitted_attributes
      [
        :name, :email
      ]
    end

    def set_user
      @user = Swattr::User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(permitted_attributes)
    end
  end
end
