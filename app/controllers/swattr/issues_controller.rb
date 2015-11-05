module Swattr
  class IssuesController < ApplicationController
    before_action :set_project
    before_action :add_issue_defaults_on_create, only: [:create]
    before_action :set_issue, only: [:show, :new, :edit, :update, :destroy]

    def index
      @q = Swattr::Issue.where(project_id: @project.id)
        .ransack(params[:q]
        .try(:merge, m: "or"))

      @issues = @q.result(distinct: true).page(params[:page]).per(per_page)

      authorize @issues

      respond_with @issues
    end

    def show
       @task       = Swattr::Task.new
       @attachment = Swattr::Attachment.new

      respond_with @issue, @task, @attachment
    end

    def new
      respond_with @issue
    end

    def edit
      respond_with @issue
    end

    def create
      @issue = Swattr::Issue.new(issue_params)

      authorize @issue

      @issue.save

      respond_with @issue, location: -> { project_issue_path(@project, @issue) }
    end

    def update
      @issue.update(issue_params)

      respond_with @issue, location: -> { project_issue_path(@project, @issue) }
    end

    def destroy
      @issue.destroy

      respond_with @issue, location: -> { project_issues_path }
    end

    protected

    def permitted_attributes
      [
        :title, :content, :assignee_id, :priority_id, :status_id,
        :resolution_id, :due_at, :project_id, :author_id, tag_ids: []
      ]
    end

    def set_issue
      if action_name.to_sym == :new
        @issue = Swattr::Issue.new
      else
        @issue = Swattr::Issue.find(params[:id])
      end

      authorize @issue
    end

    def set_project
      @project = Swattr::Project.find_by(slug: params[:project_id])
    end

    def issue_params
      params.require(:issue).permit(permitted_attributes)
    end

    def add_issue_defaults_on_create
      project_id = @project.id
      author_id = current_user.id

      params.deep_merge!(issue: { project_id: project_id,
                                  author_id: author_id })
    end
  end
end
