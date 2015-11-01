require "rails_helper"

module Swattr
  RSpec.describe SettingsController, type: :controller do
    before { stub_authorization! }

    describe "GET #show" do
      it "assigns the requested setting as @setting" do
        swattr_get :show

        expect(assigns(:settings)).to eq(Setting.first)
      end
    end

    describe "GET #edit" do
      it "assigns the requested setting as @setting" do
        swattr_get :edit

        expect(assigns(:settings)).to eq(Setting.first)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          { title: "My Swattr" }
        end

        it "updates the requested setting" do
          swattr_put :update, settings: params

          Setting.first.reload

          expect(assigns(:settings)).to eq(Setting.first)
        end

        it "assigns the requested setting as @setting" do
          swattr_put :update, settings: params

          expect(assigns(:settings)).to eq(Setting.first)
        end

        it "redirects to the settings" do
          swattr_put :update, settings: params

          expect(response).to redirect_to(settings_path)
        end
      end

      context "with invalid params" do
        let(:params) do
          { title: nil }
        end

        it "assigns the setting as @setting" do
          swattr_put :update, settings: params

          expect(assigns(:settings)).to eq(Setting.first)
        end

        it "re-renders the 'edit' template" do
          swattr_put :update, settings: params

          expect(response).to render_template(:edit)
        end
      end
    end
  end
end
