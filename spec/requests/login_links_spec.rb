require 'rails_helper'

RSpec.describe "LoginLinks", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/login_links/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/login_links/create"
      expect(response).to have_http_status(:success)
    end
  end

end
