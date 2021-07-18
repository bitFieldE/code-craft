require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context 'レビュー記事作成' do
    it 'title/rate/contentが入力済みで成功' do
      expect(post).to be_valid
    end

    it 'title/rate/contentが未入力で失敗' do
      post.title = ''
      post.rate = ''
      post.content = ''
      expect(post).to_not be_valid
    end

    it 'rateの値が0より上で成功' do
      post.rate = 0.5
      expect(post).to be_valid
    end

    it 'rateの値が0で失敗' do
      post.rate = 0
      expect(post).to_not be_valid
    end
  end

  context 'レビュー記事更新時' do
    it 'titleカラムの文字数が、50字以下で成功' do
      post.title = user.description = Faker::Lorem.characters(number: 45)
      expect(post).to be_valid
    end

    it 'titleカラムの文字数が、50字より多い場合失敗' do
      post.title = Faker::Lorem.characters(number: 51)
      expect(post).to_not be_valid
    end
  end
end
