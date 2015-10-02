module Swattr
  class ResolutionsController < ApplicationController
    before_action :set_resolution, only: [:show, :edit, :update, :destroy]

    def index
      @resolutions = Swattr::Resolution.all

      respond_with @resolutions
    end

    def show
      respond_with @resolution
    end

    def new
      @resolution = Swattr::Resolution.new

      respond_with @resolution
    end

    def edit
      respond_with @resolution
    end

    def create
      @resolution = Swattr::Resolution.create(resolution_params)

      respond_with @resolution, location: -> { resolution_path(@resolution) }
    end

    def update
      @resolution.update(resolution_params)

      respond_with @resolution, location: -> { resolution_path(@resolution) }
    end

    def destroy
      @resolution.destroy

      respond_with @resolution, location: -> { resolutions_path }
    end

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end

    def set_resolution
      @resolution = Swattr::Resolution.find(params[:id])
    end

    def resolution_params
      params.require(:resolution).permit(permitted_attributes)
    end
  end
end
