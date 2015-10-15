module Swattr
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Swattr::Task.all

      respond_with @tasks
    end

    def show
      respond_with @task
    end

    def new
      @task = Swattr::Task.new

      respond_with @task
    end

    def edit
      respond_with @task
    end

    def create
      new_task_params = task_params.merge(
        author_id: current_user.id
      )

      @task = Swattr::Task.create(new_task_params)

      respond_with @task, location: -> { task_path(@task) }
    end

    def update
      @task.update(task_params)

      respond_with @task, location: -> { task_path(@task) }
    end

    def destroy
      @task.destroy

      respond_with @task, location: -> { tasks_path }
    end

    protected

    def permitted_attributes
      [
        :title, :issue_id, :position
      ]
    end

    def set_task
      @task = Swattr::Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(permitted_attributes)
    end
  end
end
