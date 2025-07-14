# spec/requests/user_registrations_spec.rb

require 'rails_helper'

RSpec.describe "User Registrations (Sign Up)", type: :request do
  describe "GET /users/sign_up" do
    it "returns http success" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path after successful registration" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash notice" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
      end

      it "logs in the user" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user) }
        expect(controller.current_user).to be_present
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        expect {
          post user_registration_path, params: { user: FactoryBot.attributes_for(:user, email: "invalid-email", password: "123", password_confirmation: "123") }
        }.to_not change(User, :count)
      end

      it "renders the new template with unprocessable_entity status" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user, email: "invalid-email") }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it "does not log in the user" do
        post user_registration_path, params: { user: FactoryBot.attributes_for(:user, email: "invalid-email") }
        expect(controller.current_user).to be_nil
      end
    end
  end
end
