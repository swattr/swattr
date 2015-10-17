module Swattr
  class TasksController < ApplicationController
    before_action :add_task_defaults_on_create, only: [:create]
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
      @task = Swattr::Task.create(task_params)

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
        :title, :issue_id, :position, :author_id
      ]
    end

    def set_task
      @task = Swattr::Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(permitted_attributes)
    end

    def add_task_defaults_on_create
      author_id = current_user.id

      params.deep_merge!(task: { author_id: author_id })
    end
  end
end
