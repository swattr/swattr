module Swattr
  class StatusesController < ApplicationController
    before_action :set_status, only: [:show, :edit, :update, :destroy]

    def index
      @statuses = Swattr::Status.all

      respond_with @statuses
    end

    def show
      respond_with @status
    end

    def new
      @status = Swattr::Status.new

      respond_with @status
    end

    def edit
      respond_with @status
    end

    def create
      @status = Swattr::Status.create(status_params)

      respond_with @status, location: -> { status_path(@status) }
    end

    def update
      @status.update(status_params)

      respond_with @status, location: -> { status_path(@status) }
    end

    def destroy
      @status.destroy

      respond_with @status, location: -> { statuses_path }
    end

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end

    def set_status
      @status = Swattr::Status.find(params[:id])
    end

    def status_params
      params.require(:status).permit(permitted_attributes)
    end
  end
end
