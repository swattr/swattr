module Swattr
  class ProfilesController < ApplicationController
    before_action :set_profile

    def show
    end

    def edit
    end

    def update
      empty_password_params! if profile_params[:password].blank?

      successfully_updated = if needs_password?(@profile, profile_params)
                               @profile.update(profile_params)
                             else
                               @profile.update_without_password(profile_params)
                             end

      if successfully_updated
        sign_in(@profile, bypass: true) if @profile == current_user

        redirect_to profile_path, notice: "Profile was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @profile.destroy

      redirect_to root_url, notice: "Profile was successfully destroyed."
    end

    protected

    def permitted_attributes
      [
        :name,
        :email,
        :password,
      ]
    end

    def set_profile
      @profile = User.find(current_user.id)
    end

    def profile_params
      params.require(:user).permit(permitted_attributes)
    end

    def empty_password_params!
      profile_params.delete(:password)
      profile_params.delete(:password_confirmation)
    end

    def needs_password?(profile, params)
      params[:password].present?
    end
  end
end
