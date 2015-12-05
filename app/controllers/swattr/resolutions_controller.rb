module Swattr
  class ResolutionsController < ApplicationController
    before_action :set_resolution, only: [:show, :new, :edit, :update, :destroy]

    def index
      @resolutions = Swattr::Resolution.all

      authorize @resolutions

      respond_with @resolutions
    end

    def show
      respond_with @resolution
    end

    def new
      respond_with @resolution
    end

    def edit
      respond_with @resolution
    end

    def create
      @resolution = Swattr::Resolution.new(resolution_params)

      authorize @resolution

      @resolution.save

      respond_with @resolution, location: resolution_path(@resolution)
    end

    def update
      @resolution.update(resolution_params)

      respond_with @resolution, location: resolution_path(@resolution)
    end

    def destroy
      @resolution.destroy

      respond_with @resolution, location: resolutions_path
    end

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end

    def set_resolution
      if action_name.to_sym == :new
        @resolution = Swattr::Resolution.new
      else
        @resolution = Swattr::Resolution.find(params[:id])
      end

      authorize @resolution
    end

    def resolution_params
      params.require(:resolution).permit(permitted_attributes)
    end
  end
end
