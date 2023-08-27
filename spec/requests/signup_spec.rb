require 'rails_helper'

RSpec.describe "Signups", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/signup/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/signup/create"
      expect(response).to have_http_status(:success)
    end
  end

end
