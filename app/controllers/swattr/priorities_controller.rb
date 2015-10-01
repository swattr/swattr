module Swattr
  class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:show, :edit, :update, :destroy]

    def index
      @priorities = Priority.all
    end

    def show
    end

    def new
      @priority = Priority.new
    end

    def edit
    end

    def create
      @priority = Priority.new(priority_params)

      if @priority.save
        redirect_to @priority, notice: "Priority was successfully created."
      else
        render :new
      end
    end

    def update
      if @priority.update(priority_params)
        redirect_to @priority, notice: "Priority was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @priority.destroy
      redirect_to priorities_url, notice: "Priority was successfully destroyed."
    end

    protected

    def permitted_attributes
      [
        :name,
        :description,
        :position,
      ]
    end

    def set_priority
      @priority = Priority.find(params[:id])
    end

    def priority_params
      params.require(:priority).permit(permitted_attributes)
    end
  end
end
