require 'rails_helper'

RSpec.describe 'Api::V1::EventComments', type: :request do
  describe 'GET /destroy' do
    let!(:user) { create(:user) }
    let!(:params) { { email: user.email, password: user.password } }

    # ログイン処理
    before do
      post '/api/v1/auth', params: params
    end

    it 'イベントの掲示板のコメントが削除されること' do
      post = create(:post, user: user)
      event = create(:event, user: user, post: post)
      event_comment = create(:event_comment, user: user, event: event)
      delete "/api/v1/event_comments/#{event_comment.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
