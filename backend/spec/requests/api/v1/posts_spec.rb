require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /show' do
    let(:post) { create(:post) }

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
    let!(:params) { { auth: { email: user.email, password: user.password } } }

    # ログイン処理
    before do
      post '/api/v1/user_token', params: params
    end

    it '投稿の情報を更新できること' do
      post = create(:post)
      update = { post: { title: "testpost", rate: 3.5, content: "testcontent" } }
      put "/api/v1/posts/#{post.id}", params: update
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(response).to have_http_status(:success)
      expect(json['post']['title']).to eq(update[:post][:title])
      expect(json['post']['rate']).to eq(update[:post][:rate])
      expect(json['post']['content']).to eq(update[:post][:content])
    end
  end

  describe 'GET /destroy' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }

    # ログイン処理
    before do
      post '/api/v1/user_token', params: params
    end

    it '投稿を削除できること' do
      post = create(:post)
      delete "/api/v1/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
