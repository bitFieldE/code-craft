require 'rails_helper'

RSpec.describe 'Api::V1::Events', type: :request do
  describe 'GET /show' do
    it 'returns http success' do
      get '/api/v1/events/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/events/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/events/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
