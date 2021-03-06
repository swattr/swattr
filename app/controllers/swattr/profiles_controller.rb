module Swattr
  class ProfilesController < ApplicationController
    before_action :set_profile
    after_action :skip_authorization

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

      reauth_current_user(successfully_updated)

      respond_with @profile, location: -> { profile_path }
    end

    def destroy
      @profile.destroy

      respond_with @profile, location: -> { root_path }
    end

    protected

    def permitted_attributes
      [
        :name, :email, :password, :avatar, :remove_avatar
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

    def reauth_current_user(successful)
      sign_in(@profile, bypass: true) if successful && @profile == current_user
    end
  end
end
