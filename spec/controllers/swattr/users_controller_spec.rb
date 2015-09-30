require "rails_helper"

module Swattr
  RSpec.describe UsersController, type: :controller do
    before { stub_authorization! }

    it "uses correct layout" do
      swattr_get :index

      expect(response).to render_template(layout: "swattr/layouts/application")
    end

    describe "GET #index" do
      it "assigns all users as @users" do
        user = create(:user)

        swattr_get :index

        expect(assigns[:users].size).to eq 2
      end
    end

    describe "GET #show" do
      it "assigns the requested user as @user" do
        user = create(:user)

        swattr_get :show, id: user

        expect(assigns(:user)).to eq(user)
      end
    end

    describe "GET #new" do
      it "assigns a new user as @user" do

        swattr_get :new

        expect(assigns(:user)).to be_a_new(User)
      end
    end

    describe "GET #edit" do
      it "assigns the requested user as @user" do
        user = create(:user)

        get :edit, id: user.to_param

        expect(assigns(:user)).to eq(user)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        let(:attributes) { {
          email: "fake_email@example.com",
          password: "password"
        } }

        it "creates a new User" do
          expect {
            swattr_post :create, user: attributes
          }.to change(User, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          swattr_post :create, user: attributes

          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end

        it "redirects to the created user" do
          swattr_post :create, user: attributes

          expect(response).to redirect_to(User.last)
        end
      end

      context "with invalid params" do
        let(:attributes) { { email: "fake_email@example.com" } }

        it "assigns a newly created but unsaved user as @user" do
          swattr_post :create, user: attributes

          expect(assigns(:user)).to be_a_new(User)
        end

        it "re-renders the 'new' template" do
          swattr_post :create, user: attributes

          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params, with password" do
        let(:attributes) { {
          name: "Fancy Name",
          password: "new password"
        } }

        it "assigns the requested user as @user" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(response).to redirect_to(user)
        end
      end

      context "with valid params, without password" do
        let(:attributes) { {
          name: "Fancy Name"
        } }

        it "assigns the requested user as @user" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(assigns(:user)).to eq(user)
        end

        it "redirects to the user" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(response).to redirect_to(user)
        end
      end

      context "with invalid params" do
        let(:attributes) { {
          name: "Fancy Name",
          password: "no"
        } }

        it "assigns the user as @user" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = create(:user)

          swattr_put :update, id: user.to_param, user: attributes

          expect(response).to render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        user = create(:user)

        expect {
          delete :destroy, { id: user.to_param }
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = create(:user)

        delete :destroy, { id: user.to_param }

        expect(response).to redirect_to(users_url)
      end
    end
  end
end
