module Swattr
  class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:show, :edit, :update, :destroy]

    def index
      @priorities = Swattr::Priority.all

      respond_with @priorities
    end

    def show
      respond_with @priority
    end

    def new
      @priority = Swattr::Priority.new

      respond_with @priority
    end

    def edit
      respond_with @priority
    end

    def create
      @priority = Swattr::Priority.create(priority_params)

      respond_with @priority, location: -> { priority_path(@priority) }
    end

    def update
      @priority.update(priority_params)

      respond_with @priority, location: -> { priority_path(@priority) }
    end

    def destroy
      @priority.destroy

      respond_with @priority, location: -> { priorities_path }
    end

    protected

    def permitted_attributes
      [
        :name, :description, :position
      ]
    end

    def set_priority
      @priority = Swattr::Priority.find(params[:id])
    end

    def priority_params
      params.require(:priority).permit(permitted_attributes)
    end
  end
end
