module Swattr
  class IssuesController < ApplicationController
    before_action :set_issue, only: [:show, :edit, :update, :destroy]

    def index
      @issues = Issue.all
    end

    def show
    end

    def new
      @issue = Issue.new
    end

    def edit
    end

    def create
      @issue = Issue.new(issue_params)

      if @issue.save
        redirect_to @issue, notice: "Issue was successfully created."
      else
        render :new
      end
    end

    def update
      if @issue.update(issue_params)
        redirect_to @issue, notice: "Issue was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @issue.destroy
      redirect_to issues_url, notice: "Issue was successfully destroyed."
    end

    protected

    def permitted_attributes
      [
        :title,
        :content,
        :project_id,
        :author_id,
        :assignee_id,
        :priority_id,
        :status_id,
        :resolution_id,
        :due_at,
      ]
    end

    def set_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(permitted_attributes)
    end
  end
end
