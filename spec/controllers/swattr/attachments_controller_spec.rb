require "rails_helper"

module Swattr
  RSpec.describe AttachmentsController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "POST #create" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          {
            title: "Attachment title",
            source: fixture_file_upload("spec/support/uploads/file.gif")
          }
        end

        it "creates a new Attachment" do
          expect do
            swattr_post :create, project_id: issue.project.slug,
                                 issue_id: issue.id,
                                 attachment: params
          end.to change(Attachment, :count).by(1)
        end

        it "assigns a newly created attachment as @attachment" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               attachment: params

          expect(assigns(:attachment)).to be_a(Attachment)
          expect(assigns(:attachment)).to be_persisted
        end

        it "redirects to the created attachment" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               attachment: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          { title: "New attachment title" }
        end

        it "updates the requested attachment" do
          attachment = create(:attachment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: attachment,
                              attachment: params

          attachment.reload

          expect(assigns(:attachment)).to eq(attachment)
        end

        it "assigns the requested attachment as @attachment" do
          attachment = create(:attachment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: attachment,
                              attachment: params

          expect(assigns(:attachment)).to eq(attachment)
        end

        it "redirects to the attachment" do
          attachment = create(:attachment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: attachment,
                              attachment: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "DELETE #destroy" do
      let(:issue) { create(:issue) }

      it "redirects to the attachments list" do
        attachment = create(:attachment)

        swattr_delete :destroy, project_id: issue.project.slug,
                                issue_id: issue.id,
                                id: attachment

        expect(response).to redirect_to(project_issue_path(issue.project,
                                                           issue))
      end
    end
  end
end
