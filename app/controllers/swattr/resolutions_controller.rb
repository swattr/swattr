module Swattr
  class ResolutionsController < ApplicationController
    before_action :set_resolution, only: [:show, :edit, :update, :destroy]

    def index
      @resolutions = Resolution.all
    end

    def show
    end

    def new
      @resolution = Resolution.new
    end

    def edit
    end

    def create
      @resolution = Resolution.new(resolution_params)

      if @resolution.save
        redirect_to @resolution, notice: "Resolution was successfully created."
      else
        render :new
      end
    end

    def update
      if @resolution.update(resolution_params)
        redirect_to @resolution, notice: "Resolution was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @resolution.destroy
      redirect_to resolutions_url, notice: "Resolution was successfully destroyed."
    end

    protected

    def permitted_attributes
      [
        :name,
        :description,
        :position,
      ]
    end

    def set_resolution
      @resolution = Resolution.find(params[:id])
    end

    def resolution_params
      params.require(:resolution).permit(permitted_attributes)
    end
  end
end
