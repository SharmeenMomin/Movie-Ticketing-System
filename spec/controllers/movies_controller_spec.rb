require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let(:admin) { create(:user, username: "Admin") }
  let(:user) { create(:user, username: "RegularUser") }
  let(:movie) { create(:movie) }

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: movie.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    context "when admin is logged in" do
      # before { sign_in admin }
      before do
        session[:user_id] = admin.id  # Simulate admin login
      end

      it "returns a successful response" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context "when non-admin user tries to access" do
      before do
        session[:user_id] = user.id  # Simulate non-admin user login
      end

      it "redirects to movies path with an alert" do
        get :new
        expect(response).to redirect_to(movies_path)
        expect(flash[:alert]).to eq("Access denied!")
      end
    end
  end

  describe "POST #create" do
    context "when admin is logged in" do
      before do
        session[:user_id] = admin.id  # Simulate admin login
      end

      it "creates a new movie" do
        expect {
          post :create, params: { movie: attributes_for(:movie) }
        }.to change(Movie, :count).by(1)

        expect(response).to redirect_to(Movie.last)
      end
    end

    context "when non-admin user tries to create a movie" do
      before do
        session[:user_id] = user.id  # Simulate non-admin user login
      end

      it "does not allow movie creation" do
        post :create, params: { movie: attributes_for(:movie) }
        expect(response).to redirect_to(movies_path)
        expect(flash[:alert]).to eq("Access denied!")
      end
    end
  end

  describe "PATCH #update" do
    context "when admin is logged in" do
      before do
        session[:user_id] = admin.id  # Simulate admin login
      end

      it "updates the movie" do
        patch :update, params: { id: movie.id, movie: { title: "Updated Title" } }
        movie.reload
        expect(movie.title).to eq("Updated Title")
        expect(response).to redirect_to(movie)
      end
    end

    context "when non-admin user tries to update" do
      before do
        session[:user_id] = user.id  # Simulate non-admin user login
      end

      it "redirects with an alert" do
        patch :update, params: { id: movie.id, movie: { title: "Hacked Title" } }
        expect(response).to redirect_to(movies_path)
        expect(flash[:alert]).to eq("Access denied!")
      end
    end
  end

  describe "DELETE #destroy" do
    context "when admin is logged in" do
      before do
        session[:user_id] = admin.id  # Simulate admin login
      end
      let!(:movie) { create(:movie) }

      it "deletes the movie" do
        expect {
          delete :destroy, params: { id: movie.id }
        }.to change(Movie, :count).by(-1)

        expect(response).to redirect_to(admin_dashboard_path)
      end
    end

    context "when non-admin user tries to delete" do
      before do
        session[:user_id] = user.id  # Simulate non-admin user login
      end

      it "does not allow movie deletion" do
        delete :destroy, params: { id: movie.id }
        expect(response).to redirect_to(movies_path)
        expect(flash[:alert]).to eq("Access denied!")
      end
    end
  end
end
