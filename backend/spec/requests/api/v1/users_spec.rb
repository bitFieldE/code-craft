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
end
