require 'rails_helper'

RSpec.describe 'Api::V1::UserTokens', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user) }

    it 'ログインできること' do
      params = { auth: { email: user.email, password: user.password } }
      post '/api/v1/user_token', params: params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /destroy' do
    let(:user) { create(:user) }

    it 'ログアウトできること' do
      params = { auth: { email: user.email, password: user.password } }
      post '/api/v1/user_token', params: params
      expect(response).to have_http_status(:success)
    end
  end
end
