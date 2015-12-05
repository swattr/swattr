module Swattr
  class CommentsController < ApplicationController
    before_action :set_issue
    before_action :add_comment_defaults_on_create, only: [:create]
    before_action :set_comment, only: [:update, :destroy]

    def create
      @comment = Swattr::Comment.new(comment_params)

      authorize @comment

      @comment.save

      respond_with @comment,
                   location: project_issue_path(@project, @issue)
    end

    def update
      @comment.update(comment_params)

      respond_with @comment,
                   location: project_issue_path(@project, @issue)
    end

    def destroy
      @comment.destroy

      respond_with @comment,
                   location: project_issue_path(@project, @issue)
    end

    protected

    def permitted_attributes
      [
        :issue_id, :author_id, :body
      ]
    end

    def set_issue
      @issue   = Swattr::Issue.find_by(id: params[:issue_id])
      @project = Swattr::Project.find_by(id: @issue.project_id)
    end

    def set_comment
      @comment = Swattr::Comment.find(params[:id])

      authorize @comment
    end

    def comment_params
      params.require(:comment).permit(permitted_attributes)
    end

    def add_comment_defaults_on_create
      author_id = current_user.id

      params.deep_merge!(comment: { author_id: author_id,
                                    issue_id: @issue.id })
    end
  end
end
