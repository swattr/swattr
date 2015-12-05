module Swattr
  class StatusesController < ApplicationController
    before_action :set_status, only: [:show, :new, :edit, :update, :destroy]

    def index
      @statuses = Swattr::Status.all

      authorize @statuses

      respond_with @statuses
    end

    def show
      respond_with @status
    end

    def new
      respond_with @status
    end

    def edit
      respond_with @status
    end

    def create
      @status = Swattr::Status.new(status_params)

      authorize @status

      @status.save

      respond_with @status, location: status_path(@status)
    end

    def update
      @status.update(status_params)

      respond_with @status, location: status_path(@status)
    end

    def destroy
      @status.destroy

      respond_with @status, location: statuses_path
    end

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end

    def set_status
      if action_name.to_sym == :new
        @status = Swattr::Status.new
      else
        @status = Swattr::Status.find(params[:id])
      end

      authorize @status
    end

    def status_params
      params.require(:status).permit(permitted_attributes)
    end
  end
end
