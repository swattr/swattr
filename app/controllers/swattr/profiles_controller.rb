module Swattr
  class ProfilesController < ApplicationController
    before_action :set_profile

    def show
      respond_with @profile
    end

    def edit
      respond_with @profile
    end

    def update
      empty_password_params! if profile_params[:password].blank?

      successfully_updated = if needs_password?(@profile, profile_params)
                               @profile.update(profile_params)
                             else
                               @profile.update_without_password(profile_params)
                             end

      if successfully_updated && @profile == current_user
        sign_in(@profile, bypass: true)
      end

      respond_with @profile, location: -> { profile_path }
    end

    def destroy
      @profile.destroy

      respond_with @profile, location: -> { root_path }
    end

    protected

    def permitted_attributes
      [
        :name, :email, :password, :avatar
      ]
    end

    def set_profile
      @profile = current_user
    end

    def profile_params
      params.require(:profile).permit(permitted_attributes)
    end

    def empty_password_params!
      profile_params.delete(:password)
      profile_params.delete(:password_confirmation)
    end

    def needs_password?(_profile, params)
      params[:password].present?
    end
  end
end
