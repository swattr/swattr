require "rails_helper"

module Swattr
  RSpec.describe ResolutionsController, type: :controller do
    before { stub_authorization! }

    describe "GET #index" do
      it "assigns all resolutions as @resolutions" do
        resolution = create(:resolution)

        swattr_get :index

        expect(assigns(:resolutions)).to eq([resolution])
      end
    end

    describe "GET #show" do
      it "assigns the requested resolution as @resolution" do
        resolution = create(:resolution)

        swattr_get :show, id: resolution

        expect(assigns(:resolution)).to eq(resolution)
      end
    end

    describe "GET #new" do
      it "assigns a new resolution as @resolution" do
        swattr_get :new

        expect(assigns(:resolution)).to be_a_new(Resolution)
      end
    end

    describe "GET #edit" do
      it "assigns the requested resolution as @resolution" do
        resolution = create(:resolution)

        swattr_get :edit, id: resolution

        expect(assigns(:resolution)).to eq(resolution)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:params) do
          { name: "New Resolution" }
        end

        it "creates a new Resolution" do
          expect do
            swattr_post :create, resolution: params
          end.to change(Resolution, :count).by(1)
        end

        it "assigns a newly created resolution as @resolution" do
          swattr_post :create, resolution: params

          expect(assigns(:resolution)).to be_a(Resolution)
          expect(assigns(:resolution)).to be_persisted
        end

        it "redirects to the created resolution" do
          swattr_post :create, resolution: params

          expect(response).to redirect_to(Resolution.last)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns a newly created but unsaved resolution as @resolution" do
          swattr_post :create, resolution: params

          expect(assigns(:resolution)).to be_a_new(Resolution)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, resolution: params

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { name: "New resolution title" }
        end

        it "updates the requested resolution" do
          resolution = create(:resolution)

          swattr_put :update, id: resolution, resolution: params

          resolution.reload

          expect(assigns(:resolution)).to eq(resolution)
        end

        it "assigns the requested resolution as @resolution" do
          resolution = create(:resolution)

          swattr_put :update, id: resolution, resolution: params

          expect(assigns(:resolution)).to eq(resolution)
        end

        it "redirects to the resolution" do
          resolution = create(:resolution)

          swattr_put :update, id: resolution, resolution: params

          expect(response).to redirect_to(resolution)
        end
      end

      context "with invalid params" do
        let(:params) do
          { name: nil }
        end

        it "assigns the resolution as @resolution" do
          resolution = create(:resolution)

          swattr_put :update, id: resolution, resolution: params

          expect(assigns(:resolution)).to eq(resolution)
        end

        it "re-renders the 'edit' template" do
          resolution = create(:resolution)

          swattr_put :update, id: resolution, resolution: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested resolution" do
        resolution = create(:resolution)

        expect do
          swattr_delete :destroy, id: resolution
        end.to change(Resolution, :count).by(-1)
      end

      it "redirects to the resolutions list" do
        resolution = create(:resolution)

        swattr_delete :destroy, id: resolution

        expect(response).to redirect_to(resolutions_url)
      end
    end
  end
end
