module Swattr
  class AttachmentsController < ApplicationController
    before_action :set_issue
    before_action :add_attachment_defaults_on_create, only: [:create]
    before_action :set_attachment, only: [:update, :destroy]

    def create
      @attachment = Swattr::Attachment.new(attachment_params)

      authorize @attachment

      @attachment.save

      respond_with @attachment,
                   location: project_issue_path(@project, @issue)
    end

    def update
      @attachment.update(attachment_params)

      respond_with @attachment,
                   location: project_issue_path(@project, @issue)
    end

    def destroy
      @attachment.destroy

      respond_with @attachment,
                   location: project_issue_path(@project, @issue)
    end

    protected

    def permitted_attributes
      [
        :title, :description, :source, :remove_source, :uploader_id, :issue_id
      ]
    end

    def set_issue
      @issue   = Swattr::Issue.find_by(id: params[:issue_id])
      @project = Swattr::Project.find_by(id: @issue.project_id)
    end

    def set_attachment
      @attachment = Swattr::Attachment.find(params[:id])

      authorize @attachment
    end

    def attachment_params
      params.require(:attachment).permit(permitted_attributes)
    end

    def add_attachment_defaults_on_create
      uploader_id = current_user.id

      params.deep_merge!(attachment: { uploader_id: uploader_id,
                                       issue_id: @issue.id })
    end
  end
end
