module Swattr
  class IssuesController < ApplicationController
    before_action :set_project
    before_action :add_issue_defaults_on_create, only: [:create]
    before_action :set_issue, only: [:show, :edit, :update, :destroy]

    def index
      @q = Swattr::Issue.where(project_id: @project.id)
        .ransack(params[:q]
        .try(:merge, m: "or"))

      @issues = @q.result(distinct: true).page(params[:page]).per(per_page)

      respond_with @issues
    end

    def show
      respond_with @issue
    end

    def new
      @issue = Swattr::Issue.new

      respond_with @issue
    end

    def edit
      respond_with @issue
    end

    def create
      @issue = Swattr::Issue.create(issue_params)

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
      @issue = Swattr::Issue.find(params[:id])
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

      params.deep_merge!(issue: {
        project_id: project_id,
        author_id: author_id
      })
    end
  end
end
