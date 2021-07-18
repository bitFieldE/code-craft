require 'rails_helper'

RSpec.describe 'Api::V1::EventComments', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/event_comments/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/event_comments/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
