require 'rails_helper'

RSpec.describe 'Api::V1::Passwords', type: :request do
  describe 'GET /update' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }
    let!(:change_password) { { user: { current_password: user.password, password: 'testpassword', password_confirmation: 'testpassword' } } }

    before do
      post '/api/v1/user_token', params: params
      put api_v1_passwords_path(change_password)
    end

    it 'パスワードの変更ができること' do
      expect(response).to have_http_status(:ok)
    end
  end
end
