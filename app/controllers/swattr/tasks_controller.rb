module Swattr
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Task.all
    end

    def show
    end

    def new
      @task = Task.new
    end

    def edit
    end

    def create
      @task = Task.new(task_params)

      if @task.save
        redirect_to @task, notice: "Task was successfully created."
      else
        render :new
      end
    end

    def update
      if @task.update(task_params)
        redirect_to @task, notice: "Task was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @task.destroy
      redirect_to tasks_url, notice: "Task was successfully destroyed."
    end

    private

    def permitted_attributes
      [
        :title,
        :issue_id,
        :author_id,
        :position,
      ]
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(permitted_attributes)
    end
  end
end
