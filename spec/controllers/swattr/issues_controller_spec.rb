require "rails_helper"

module Swattr
  RSpec.describe IssuesController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "GET #index" do
      it "assigns all issues as @issues" do
        issue = create(:issue)

        swattr_get :index, project_id: issue.project

        expect(assigns(:issues)).to eq([issue])
      end
    end

    describe "GET #show" do
      it "assigns the requested issue as @issue" do
        issue = create(:issue)

        swattr_get :show, project_id: issue.project, id: issue

        expect(assigns(:issue)).to eq(issue)
      end
    end

    describe "GET #new" do
      it "assigns a new issue as @issue" do
        project = create(:project)

        swattr_get :new, project_id: project

        expect(assigns(:issue)).to be_a_new(Issue)
      end
    end

    describe "GET #edit" do
      it "assigns the requested issue as @issue" do
        issue = create(:issue)

        swattr_get :edit, project_id: issue.project, id: issue

        expect(assigns(:issue)).to eq(issue)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:project) { create(:project) }
        let(:params) do
          {
            title: "New Issue",
            content: "This is the body of the issue.",
            project_id: project.id
          }
        end

        it "creates a new Issue" do
          expect do
            swattr_post :create, project_id: project, issue: params
          end.to change(Issue, :count).by(1)
        end

        it "assigns a newly created issue as @issue" do
          swattr_post :create, project_id: project, issue: params

          expect(assigns(:issue)).to be_a(Issue)
          expect(assigns(:issue)).to be_persisted
        end

        it "redirects to the created issue" do
          swattr_post :create, project_id: project, issue: params

          expect(response).to redirect_to([project, Issue.last])
        end
      end

      context "with invalid params" do
        let(:project) { create(:project) }
        let(:params) do
          { title: nil }
        end

        it "assigns a newly created but unsaved issue as @issue" do
          swattr_post :create, project_id: project, issue: params

          expect(assigns(:issue)).to be_a_new(Issue)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, project_id: project, issue: params

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { title: "New issue title" }
        end

        it "updates the requested issue" do
          issue = create(:issue)

          swattr_put :update, project_id: issue.project,
                              id: issue,
                              issue: params

          issue.reload

          expect(assigns(:issue)).to eq(issue)
        end

        it "assigns the requested issue as @issue" do
          issue = create(:issue)

          swattr_put :update, project_id: issue.project,
                              id: issue,
                              issue: params

          expect(assigns(:issue)).to eq(issue)
        end

        it "redirects to the issue" do
          issue = create(:issue)

          swattr_put :update, project_id: issue.project,
                              id: issue,
                              issue: params

          expect(response).to redirect_to([issue.project, issue])
        end
      end

      context "with invalid params" do
        let(:params) do
          { title: nil }
        end

        it "assigns the issue as @issue" do
          issue = create(:issue)

          swattr_put :update, project_id: issue.project,
                              id: issue,
                              issue: params

          expect(assigns(:issue)).to eq(issue)
        end

        it "re-renders the 'edit' template" do
          issue = create(:issue)

          swattr_put :update, project_id: issue.project,
                              id: issue,
                              issue: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested issue" do
        issue = create(:issue)

        expect do
          swattr_delete :destroy, project_id: issue.project, id: issue
        end.to change(Issue, :count).by(-1)
      end

      it "redirects to the issues list" do
        issue = create(:issue)

        swattr_delete :destroy, project_id: issue.project, id: issue

        expect(response).to redirect_to(project_issues_url)
      end
    end
  end
end
