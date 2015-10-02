module Swattr
  class IssuesController < ApplicationController
    before_action :set_issue, only: [:show, :edit, :update, :destroy]

    def index
      @issues = Swattr::Issue.all

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

      respond_with @issue, location: -> { issue_path(@issue) }
    end

    def update
      @issue.update(issue_params)

      respond_with @issue, location: -> { issue_path(@issue) }
    end

    def destroy
      @issue.destroy

      respond_with @issue, location: -> { issues_path }
    end

    protected

    def permitted_attributes
      [
        :title, :content, :project_id, :author_id, :assignee_id, :priority_id,
        :status_id, :resolution_id, :due_at
      ]
    end

    def set_issue
      @issue = Swattr::Issue.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(permitted_attributes)
    end
  end
end
