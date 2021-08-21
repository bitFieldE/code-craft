require 'rails_helper'

RSpec.describe 'Api::V1::Events', type: :request do
  describe 'GET /show' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:event) { create(:event, user: user, post: post) }

    it 'イベントの詳細が表示されること' do
      get "/api/v1/events/#{event.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }

    # ログイン処理
    before do
      post '/api/v1/auth', params: params
    end

    it 'イベントの情報を更新できること' do
      post = create(:post, user: user)
      event = create(:event, user: user, post: post)
      update = { event: { title: 'testpost', participant_number: 10, content: 'testcontent', place: 'testplace' } }
      put "/api/v1/events/#{event.id}", params: update
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(response).to have_http_status(:success)
      expect(json['title']).to eq(update[:event][:title])
      expect(json['participant_number']).to eq(update[:event][:participant_number])
      expect(json['place']).to eq(update[:event][:place])
    end
  end

  describe 'GET /destroy' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }

    # ログイン処理
    before do
      post '/api/v1/auth', params: params
    end

    it 'イベントが削除されること' do
      post = create(:post, user: user)
      event = create(:event, user: user, post: post)
      delete "/api/v1/events/#{event.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
