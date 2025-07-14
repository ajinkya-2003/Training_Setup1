# spec/requests/user_sessions_spec.rb

require 'rails_helper'

RSpec.describe "User Sessions (Sign In/Out)", type: :request do
  # Use `let!` to ensure the user is created before each example
  let!(:user) { FactoryBot.create(:user, email: "test@example.com", password: "password123") }

  describe "GET /users/sign_in" do
    it "returns http success" do
      get new_user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users/sign_in" do
    context "with valid credentials" do
      it "logs in the user" do
        post user_session_path, params: { user: { email: user.email, password: "password123" } }
        expect(controller.current_user).to eq(user)
      end

      it "redirects to the root path after successful login" do
        post user_session_path, params: { user: { email: user.email, password: "password123" } }
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash notice" do
        post user_session_path, params: { user: { email: user.email, password: "password123" } }
        expect(flash[:notice]).to eq("Signed in successfully.")
      end
    end

    context "with invalid credentials" do
      it "does not log in the user with wrong password" do
        post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }
        expect(controller.current_user).to be_nil
      end

      it "does not log in the user with non-existent email" do
        post user_session_path, params: { user: { email: "nonexistent@example.com", password: "password123" } }
        expect(controller.current_user).to be_nil
      end

      it "renders the new template with unprocessable_entity status" do # Changed to :unprocessable_entity (422)
        post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }
        expect(response).to have_http_status(:unprocessable_entity) # Devise often returns 422 for failed logins
        expect(response).to render_template(:new)
      end

      it "sets an alert flash message" do
        post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }
        expect(flash[:alert]).to eq("Invalid Email or password.") # Devise's default message
      end
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      # Log in the user first using Devise's test helper
      sign_in user # This helper will now be available
    end

    it "logs out the user" do
      delete destroy_user_session_path
      expect(controller.current_user).to be_nil
    end

    it "redirects to the root path after logout" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end

    it "sets a flash notice" do
      delete destroy_user_session_path
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end
