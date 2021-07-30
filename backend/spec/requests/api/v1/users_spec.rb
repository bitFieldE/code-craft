require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /show' do
    let(:user) { create(:user) }

    it 'ユーザーの情報を取得' do
      get api_v1_user_path(user.id)
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(json['name']).to eq(user.name)
      expect(json['email']).to eq(user.email)
    end
  end

  describe 'PUT /update' do
    let!(:user) { create(:user) }
    let!(:params) { { auth: { email: user.email, password: user.password } } }
    let!(:update) { { user: { name: 'testuser1', email: 'testuser1@example.com', description: 'よろしくお願いします' } } }

    before do
      post '/api/v1/user_token', params: params
    end

    it 'ユーザーの情報を更新' do
      put "/api/v1/users/#{user.id}", params: update
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(json['name']).to eq(update[:user][:name])
      expect(json['email']).to eq(update[:user][:email])
      expect(json['description']).to eq(update[:user][:description])
    end
  end
end
