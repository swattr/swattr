module Swattr
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @q = Swattr::User.ransack(params[:q].try(:merge, m: "or"))

      @users = @q.result(distinct: true).page(params[:page]).per(per_page)

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
      @user = Swattr::User.invite!(user_params)

      respond_with @user, location: -> { user_path(@user) }
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
        :name, :email, :avatar
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
