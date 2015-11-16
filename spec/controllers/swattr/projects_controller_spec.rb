require "rails_helper"

module Swattr
  RSpec.describe ProjectsController, type: :controller do
    before { stub_authorization! create(:user) }

    describe "GET #index" do
      it "assigns all projects as @projects" do
        project = create(:project)

        swattr_get :index

        expect(assigns(:projects)).to eq([project])
      end
    end

    describe "GET #show" do
      it "assigns the requested project as @project" do
        project = create(:project)

        swattr_get :show, id: project

        expect(assigns(:project)).to eq(project)
      end
    end

    describe "GET #new" do
      it "assigns a new project as @project" do
        swattr_get :new

        expect(assigns(:project)).to be_a_new(Project)
      end
    end

    describe "GET #edit" do
      it "assigns the requested project as @project" do
        project = create(:project)

        swattr_get :edit, id: project

        expect(assigns(:project)).to eq(project)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:params) do
          {
            name: "New Project",
            slug: "awesome-project"
          }
        end

        it "creates a new Project" do
          expect do
            swattr_post :create, project: params
          end.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          swattr_post :create, project: params

          expect(assigns(:project)).to be_a(Project)
          expect(assigns(:project)).to be_persisted
        end

        it "redirects to the created project" do
          swattr_post :create, project: params

          expect(response).to redirect_to(swattr.projects_path)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns a newly created but unsaved project as @project" do
          swattr_post :create, project: params

          expect(assigns(:project)).to be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, project: params

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { name: "New project title" }
        end

        it "updates the requested project" do
          project = create(:project)

          swattr_put :update, id: project, project: params

          project.reload

          expect(assigns(:project)).to eq(project)
        end

        it "assigns the requested project as @project" do
          project = create(:project)

          swattr_put :update, id: project, project: params

          expect(assigns(:project)).to eq(project)
        end

        it "redirects to the project" do
          project = create(:project)

          swattr_put :update, id: project, project: params

          expect(response).to redirect_to(swattr.projects_path)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns the project as @project" do
          project = create(:project)

          swattr_put :update, id: project, project: params

          expect(assigns(:project)).to eq(project)
        end

        it "re-renders the 'edit' template" do
          project = create(:project)

          swattr_put :update, id: project, project: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested project" do
        project = create(:project)

        expect do
          swattr_delete :destroy, id: project
        end.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        project = create(:project)

        swattr_delete :destroy, id: project

        expect(response).to redirect_to(projects_url)
      end
    end
  end
end
