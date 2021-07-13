require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    it '特定のレビュー記事が取得できること' do
      get api_v1_post_path(post.id)
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(response).to have_http_status(:success)
      expect(json['title']).to eq(post.title)
      expect(json['content']).to eq(post.content)
    end
  end

  describe 'GET /update' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post, user: user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }
    let!(:update) { { post: { title: 'testpost', rate: 3.5, content: 'testcontent' } } }

    it 'returns http success' do
      post '/api/v1/user_token', params: params
      patch "/api/v1/posts/#{post.id}", params: update
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      post '/api/v1/posts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
