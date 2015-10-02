module Swattr
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = Swattr::User.all

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
      @user = Swattr::User.create(user_params)

      respond_with @user, location: -> { user_path(@user) }
    end

    def update
      empty_password_params! if user_params[:password].blank?

      successfully_updated = if needs_password?(@user, user_params)
                               @user.update(user_params)
                             else
                               @user.update_without_password(user_params)
                             end

      if successfully_updated && @user == current_user
        sign_in(@user, bypass: true)
      end

      respond_with @user, location: -> { user_path(@user) }
    end

    def destroy
      @user.destroy

      respond_with @user, location: -> { users_path }
    end

    protected

    def permitted_attributes
      [
        :name, :email, :password
      ]
    end

    def set_user
      @user = Swattr::User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(permitted_attributes)
    end

    def empty_password_params!
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    def needs_password?(user, params)
      params[:password].present?
    end
  end
end
