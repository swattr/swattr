require "rails_helper"

module Swattr
  RSpec.describe TasksController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "POST #create" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          {
            title: "Task title"
          }
        end

        it "creates a new Task" do
          expect do
            swattr_post :create, project_id: issue.project.slug,
                                 issue_id: issue.id,
                                 task: params
          end.to change(Task, :count).by(1)
        end

        it "assigns a newly created task as @task" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               task: params

          expect(assigns(:task)).to be_a(Task)
          expect(assigns(:task)).to be_persisted
        end

        it "redirects to the created task" do
          swattr_post :create, project_id: issue.project.slug,
                               issue_id: issue.id,
                               task: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          { title: "New task title" }
        end

        it "updates the requested task" do
          task = create(:task)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: task,
                              task: params

          task.reload

          expect(assigns(:task)).to eq(task)
        end

        it "assigns the requested task as @task" do
          task = create(:task)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: task,
                              task: params

          expect(assigns(:task)).to eq(task)
        end

        it "redirects to the task" do
          task = create(:task)

          swattr_put :update, project_id: issue.project.slug,
                              issue_id: issue.id,
                              id: task,
                              task: params

          expect(response).to redirect_to(project_issue_path(issue.project,
                                                             issue))
        end
      end
    end

    describe "DELETE #destroy" do
      let(:issue) { create(:issue) }

      it "redirects to the tasks list" do
        task = create(:task)

        swattr_delete :destroy, project_id: issue.project.slug,
                                issue_id: issue.id,
                                id: task

        expect(response).to redirect_to(project_issue_path(issue.project,
                                                           issue))
      end
    end
  end
end
