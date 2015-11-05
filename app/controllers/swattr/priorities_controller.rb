module Swattr
  class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:show, :new, :edit, :update, :destroy]

    def index
      @priorities = Swattr::Priority.all

      authorize @priorities

      respond_with @priorities
    end

    def show
      respond_with @priority
    end

    def new
      respond_with @priority
    end

    def edit
      respond_with @priority
    end

    def create
      @priority = Swattr::Priority.new(priority_params)

      authorize @priority

      @priority.save

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
      if action_name.to_sym == :new
        @priority = Swattr::Priority.new
      else
        @priority = Swattr::Priority.find(params[:id])
      end

      authorize @priority
    end

    def priority_params
      params.require(:priority).permit(permitted_attributes)
    end
  end
end
