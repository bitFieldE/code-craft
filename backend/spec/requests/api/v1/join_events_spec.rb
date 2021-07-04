require 'rails_helper'

RSpec.describe "Api::V1::JoinEvents", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/join_events/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/join_events/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
