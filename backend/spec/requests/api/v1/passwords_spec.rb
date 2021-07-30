require 'rails_helper'

RSpec.describe 'Api::V1::Passwords', type: :request do
  describe 'GET /update' do
    let!(:user) { create(:user, password: 'defaultpassword', password_confirmation: 'defaultpassword') }
    let!(:params) { { auth: { email: user.email, password: 'defaultpassword' } } }
    let!(:change_password) { { user: { current_password: user.password, password: 'editpassword', password_confirmation: 'editpassword' } } }

    before do
      post '/api/v1/user_token', params: params
    end

    it 'パスワードの変更ができること' do
      put api_v1_passwords_path(change_password)
      expect(response).to have_http_status(:ok)
    end
  end
end
