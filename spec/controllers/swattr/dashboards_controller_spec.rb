require "rails_helper"

module Swattr
  RSpec.describe DashboardsController, type: :controller do
    before { stub_authorization! }

    it "uses correct layout" do
      swattr_get :show

      expect(response).to render_template(layout: "swattr/layouts/application")
    end

    describe "GET #show" do
      it "assigns the requested issue as @issue" do
        swattr_get :show

        expect(response).to render_template(:show)
      end
    end
  end
end
