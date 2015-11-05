module Swattr
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :new, :edit, :update, :destroy]

    def index
      @q = Swattr::User.ransack(params[:q].try(:merge, m: "or"))

      @users = @q.result(distinct: true).page(params[:page]).per(per_page)

      authorize @users

      respond_with @users
    end

    def show
      respond_with @user
    end

    def new
      respond_with @user
    end

    def edit
      respond_with @user
    end

    def create
      @user = Swattr::User.invite!(user_params)

      authorize @user

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
        :name, :email, :remove_avatar
      ]
    end

    def set_user
      if action_name.to_sym == :new
        @user = Swattr::User.new
      else
        @user = Swattr::User.find(params[:id])
      end

      authorize @user
    end

    def user_params
      params.require(:user).permit(permitted_attributes)
    end
  end
end
