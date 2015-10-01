require_dependency "swattr/application_controller"

module Swattr
  class ResolutionsController < ApplicationController
    before_action :set_resolution, only: [:show, :edit, :update, :destroy]

    # GET /resolutions
    def index
      @resolutions = Resolution.all
    end

    # GET /resolutions/1
    def show
    end

    # GET /resolutions/new
    def new
      @resolution = Resolution.new
    end

    # GET /resolutions/1/edit
    def edit
    end

    # POST /resolutions
    def create
      @resolution = Resolution.new(resolution_params)

      if @resolution.save
        redirect_to @resolution, notice: 'Resolution was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /resolutions/1
    def update
      if @resolution.update(resolution_params)
        redirect_to @resolution, notice: 'Resolution was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /resolutions/1
    def destroy
      @resolution.destroy
      redirect_to resolutions_url, notice: 'Resolution was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_resolution
        @resolution = Resolution.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def resolution_params
        params.require(:resolution).permit(:name, :description, :position)
      end
  end
end
