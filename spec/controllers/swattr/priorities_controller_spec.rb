require "rails_helper"

module Swattr
  RSpec.describe PrioritiesController, type: :controller do
    before { stub_authorization! }

    describe "GET #index" do
      it "assigns all priorities as @priorities" do
        priority = create(:priority)

        swattr_get :index

        expect(assigns(:priorities)).to eq([priority])
      end
    end

    describe "GET #show" do
      it "assigns the requested priority as @priority" do
        priority = create(:priority)

        swattr_get :show, id: priority

        expect(assigns(:priority)).to eq(priority)
      end
    end

    describe "GET #new" do
      it "assigns a new priority as @priority" do
        swattr_get :new

        expect(assigns(:priority)).to be_a_new(Priority)
      end
    end

    describe "GET #edit" do
      it "assigns the requested priority as @priority" do
        priority = create(:priority)

        swattr_get :edit, id: priority

        expect(assigns(:priority)).to eq(priority)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:params) do
          { name: "New Priority" }
        end

        it "creates a new Priority" do
          expect {
            swattr_post :create, { priority: params }
          }.to change(Priority, :count).by(1)
        end

        it "assigns a newly created priority as @priority" do
          swattr_post :create, { priority: params }

          expect(assigns(:priority)).to be_a(Priority)
          expect(assigns(:priority)).to be_persisted
        end

        it "redirects to the created priority" do
          swattr_post :create, { priority: params }

          expect(response).to redirect_to(Priority.last)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns a newly created but unsaved priority as @priority" do
          swattr_post :create, { priority: params }

          expect(assigns(:priority)).to be_a_new(Priority)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, { priority: params }

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { name: "New priority title" }
        end

        it "updates the requested priority" do
          priority = create(:priority)

          swattr_put :update, { id: priority, priority: params }

          priority.reload

          expect(assigns(:priority)).to eq(priority)
        end

        it "assigns the requested priority as @priority" do
          priority = create(:priority)

          swattr_put :update, { id: priority, priority: params }

          expect(assigns(:priority)).to eq(priority)
        end

        it "redirects to the priority" do
          priority = create(:priority)

          swattr_put :update, { id: priority, priority: params }

          expect(response).to redirect_to(priority)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns the priority as @priority" do
          priority = create(:priority)

          swattr_put :update, { id: priority, priority: params }

          expect(assigns(:priority)).to eq(priority)
        end

        it "re-renders the 'edit' template" do
          priority = create(:priority)

          swattr_put :update, { id: priority, priority: params }

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested priority" do
        priority = create(:priority)

        expect {
          swattr_delete :destroy, { id: priority }
        }.to change(Priority, :count).by(-1)
      end

      it "redirects to the priorities list" do
        priority = create(:priority)

        swattr_delete :destroy, { id: priority }

        expect(response).to redirect_to(priorities_url)
      end
    end
  end
end
