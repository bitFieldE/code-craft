require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/posts/index'
      expect(response).to have_http_status(:success)
    end
  end

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

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/posts/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/api/v1/posts/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/api/v1/posts/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/posts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
