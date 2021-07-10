require 'rails_helper'

RSpec.describe 'Api::V1::Tops', type: :request do
  describe 'GET /index' do
    it 'トップページに表示するデータが反映されること' do
      get "/api/v1/top"
      expect(response).to have_http_status(:success)
    end
  end
end
