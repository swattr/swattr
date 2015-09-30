module Swattr
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def edit
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to @user, notice: "User was successfully created."
      else
        render :new
      end
    end

    def update
      empty_password_params! if user_params[:password].blank?

      successfully_updated = if needs_password?(@user, user_params)
                               @user.update(user_params)
                             else
                               @user.update_without_password(user_params)
                             end

      if successfully_updated
        sign_in(@user, bypass: true) if @user == current_user

        redirect_to user_path(@user), notice: "User was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @user.destroy

      redirect_to users_url, notice: "User was successfully destroyed."
    end

    protected

    def permitted_attributes
      [
        :name,
        :email,
        :password,
      ]
    end

    def set_user
      @user = User.find(params[:id])
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
