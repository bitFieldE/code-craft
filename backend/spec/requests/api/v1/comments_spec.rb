require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  describe 'GET /destroy' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }

    # ログイン処理
    before do
      post '/api/v1/user_token', params: params
    end

    it 'コメントが削除できること' do
      comment = create(:comment)
      delete "/api/v1/comments/#{comment.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
