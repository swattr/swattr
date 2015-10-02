require "rails_helper"

module Swattr
  RSpec.describe StatusesController, type: :controller do
    before { stub_authorization! }

    describe "GET #index" do
      it "assigns all statuses as @statuses" do
        status = create(:status)

        swattr_get :index

        expect(assigns(:statuses)).to eq([status])
      end
    end

    describe "GET #show" do
      it "assigns the requested status as @status" do
        status = create(:status)

        swattr_get :show, id: status

        expect(assigns(:status)).to eq(status)
      end
    end

    describe "GET #new" do
      it "assigns a new status as @status" do
        swattr_get :new

        expect(assigns(:status)).to be_a_new(Status)
      end
    end

    describe "GET #edit" do
      it "assigns the requested status as @status" do
        status = create(:status)

        swattr_get :edit, id: status

        expect(assigns(:status)).to eq(status)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:params) do
          { name: "New Status" }
        end

        it "creates a new Status" do
          expect do
            swattr_post :create, status: params
          end.to change(Status, :count).by(1)
        end

        it "assigns a newly created status as @status" do
          swattr_post :create, status: params

          expect(assigns(:status)).to be_a(Status)
          expect(assigns(:status)).to be_persisted
        end

        it "redirects to the created status" do
          swattr_post :create, status: params

          expect(response).to redirect_to(Status.last)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns a newly created but unsaved status as @status" do
          swattr_post :create, status: params

          expect(assigns(:status)).to be_a_new(Status)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, status: params

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { name: "New status title" }
        end

        it "updates the requested status" do
          status = create(:status)

          swattr_put :update, id: status, status: params

          status.reload

          expect(assigns(:status)).to eq(status)
        end

        it "assigns the requested status as @status" do
          status = create(:status)

          swattr_put :update, id: status, status: params

          expect(assigns(:status)).to eq(status)
        end

        it "redirects to the status" do
          status = create(:status)

          swattr_put :update, id: status, status: params

          expect(response).to redirect_to(status)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns the status as @status" do
          status = create(:status)

          swattr_put :update, id: status, status: params

          expect(assigns(:status)).to eq(status)
        end

        it "re-renders the 'edit' template" do
          status = create(:status)

          swattr_put :update, id: status, status: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested status" do
        status = create(:status)

        expect do
          swattr_delete :destroy, id: status
        end.to change(Status, :count).by(-1)
      end

      it "redirects to the statuses list" do
        status = create(:status)

        swattr_delete :destroy, id: status

        expect(response).to redirect_to(statuses_url)
      end
    end
  end
end
