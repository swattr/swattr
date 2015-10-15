require "rails_helper"

module Swattr
  RSpec.describe TasksController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "GET #index" do
      it "assigns all tasks as @tasks" do
        task = create(:task)

        swattr_get :index

        expect(assigns(:tasks)).to eq([task])
      end
    end

    describe "GET #show" do
      it "assigns the requested task as @task" do
        task = create(:task)

        swattr_get :show, id: task

        expect(assigns(:task)).to eq(task)
      end
    end

    describe "GET #new" do
      it "assigns a new task as @task" do
        swattr_get :new

        expect(assigns(:task)).to be_a_new(Task)
      end
    end

    describe "GET #edit" do
      it "assigns the requested task as @task" do
        task = create(:task)

        swattr_get :edit, id: task

        expect(assigns(:task)).to eq(task)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:issue) { create(:issue) }
        let(:params) do
          {
            title: "New Task",
            issue_id: issue.id
          }
        end

        it "creates a new Task" do
          expect do
            swattr_post :create, task: params
          end.to change(Task, :count).by(1)
        end

        it "assigns a newly created task as @task" do
          swattr_post :create, task: params

          expect(assigns(:task)).to be_a(Task)
          expect(assigns(:task)).to be_persisted
        end

        it "redirects to the created task" do
          swattr_post :create, task: params

          expect(response).to redirect_to(Task.last)
        end
      end

      context "with invalid params" do
        let(:params) do
          { title: nil }
        end

        it "assigns a newly created but unsaved task as @task" do
          swattr_post :create, task: params

          expect(assigns(:task)).to be_a_new(Task)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, task: params

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { title: "New task title" }
        end

        it "updates the requested task" do
          task = create(:task)

          swattr_put :update, id: task, task: params

          task.reload

          expect(assigns(:task)).to eq(task)
        end

        it "assigns the requested task as @task" do
          task = create(:task)

          swattr_put :update, id: task, task: params

          expect(assigns(:task)).to eq(task)
        end

        it "redirects to the task" do
          task = create(:task)

          swattr_put :update, id: task, task: params

          expect(response).to redirect_to(task)
        end
      end

      context "with invalid params" do
        let(:params) do
          { title: nil }
        end

        it "assigns the task as @task" do
          task = create(:task)

          swattr_put :update, id: task, task: params

          expect(assigns(:task)).to eq(task)
        end

        it "re-renders the 'edit' template" do
          task = create(:task)

          swattr_put :update, id: task, task: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested task" do
        task = create(:task)

        expect do
          swattr_delete :destroy, id: task
        end.to change(Task, :count).by(-1)
      end

      it "redirects to the tasks list" do
        task = create(:task)

        swattr_delete :destroy, id: task

        expect(response).to redirect_to(tasks_url)
      end
    end
  end
end
