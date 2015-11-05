module Swattr
  class TasksController < ApplicationController
    before_action :set_issue
    before_action :add_task_defaults_on_create, only: [:create]
    before_action :set_task, only: [:update, :destroy]

    def create
      @task = Swattr::Task.new(task_params)

      authorize @task

      @task.save

      respond_with @task, location: -> { project_issue_path(@project, @issue) }
    end

    def update
      @task.update(task_params)

      respond_with @task, location: -> { project_issue_path(@project, @issue) }
    end

    def destroy
      @task.update_attributes(deleted_at: Time.current,
                              deleted_by: current_user.id)

      respond_with @task, location: -> { project_issue_path(@project, @issue) }
    end

    protected

    def permitted_attributes
      [
        :title, :issue_id, :author_id, :position
      ]
    end

    def set_issue
      @issue   = Swattr::Issue.find_by(id: params[:issue_id])
      @project = Swattr::Project.find_by(id: @issue.project_id)
    end

    def set_task
      @task = Swattr::Task.find(params[:id])

      authorize @task
    end

    def task_params
      params.require(:task).permit(permitted_attributes)
    end

    def add_task_defaults_on_create
      author_id = current_user.id

      params.deep_merge!(task: { author_id: author_id,
                                 issue_id: @issue.id })
    end
  end
end
