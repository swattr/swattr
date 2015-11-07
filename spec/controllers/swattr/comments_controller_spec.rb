require "rails_helper"

module Swattr
  RSpec.describe CommentsController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "POST #create" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          {
            body: "Comment body"
          }
        end

        it "creates a new Comment" do
          expect do
            swattr_post :create, project_id: issue.project.slug,
                                 issue_id: issue.id,
                                 comment: params
          end.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               comment: params

          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to the created comment" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               comment: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          { comment: "New comment body" }
        end

        it "updates the requested comment" do
          comment = create(:comment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: comment,
                              comment: params

          comment.reload

          expect(assigns(:comment)).to eq(comment)
        end

        it "assigns the requested comment as @comment" do
          comment = create(:comment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: comment,
                              comment: params

          expect(assigns(:comment)).to eq(comment)
        end

        it "redirects to the comment" do
          comment = create(:comment)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: comment,
                              comment: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "DELETE #destroy" do
      let(:issue) { create(:issue) }

      it "redirects to the comments list" do
        comment = create(:comment)

        swattr_delete :destroy, project_id: issue.project.slug,
                                issue_id: issue.id,
                                id: comment

        expect(response).to redirect_to(project_issue_path(issue.project,
                                                           issue))
      end
    end
  end
end
