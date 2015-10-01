require_dependency "swattr/application_controller"

module Swattr
  class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:show, :edit, :update, :destroy]

    # GET /priorities
    def index
      @priorities = Priority.all
    end

    # GET /priorities/1
    def show
    end

    # GET /priorities/new
    def new
      @priority = Priority.new
    end

    # GET /priorities/1/edit
    def edit
    end

    # POST /priorities
    def create
      @priority = Priority.new(priority_params)

      if @priority.save
        redirect_to @priority, notice: 'Priority was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /priorities/1
    def update
      if @priority.update(priority_params)
        redirect_to @priority, notice: 'Priority was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /priorities/1
    def destroy
      @priority.destroy
      redirect_to priorities_url, notice: 'Priority was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_priority
        @priority = Priority.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def priority_params
        params.require(:priority).permit(:name, :description, :position)
      end
  end
end
