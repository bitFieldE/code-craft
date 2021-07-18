require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  context 'ユーザー登録時' do
    it 'name/email/password/password_confirmationが設定済みで成功' do
      expect(user).to be_valid
    end

    it 'name/email/password/password_confirmationが未設定で失敗' do
      user.name = ''
      user.email = ''
      user.password = ''
      user.password_confirmation = ''
      expect(user).to_not be_valid
    end

    it 'name/email/password/password_confirmationが一意(ユニーク)で成功' do
      expect(user2).to be_valid
    end

    it 'name/email/password/password_confirmationが一意(ユニーク)でない場合失敗' do
      user2.name = user.name
      user2.email = user.email
      user2.password = user.password
      user2.password_confirmation = user.password_confirmation
      expect(user2).to_not be_valid
    end
  end

  context 'ユーザー更新時' do
    it 'descriptionカラムの文字数が、1000字以下で成功' do
      user.description = Faker::Lorem.characters(number: 800)
      expect(user).to be_valid
    end

    it 'descriptionカラムの文字数が、1000字より多い場合失敗' do
      user.description = Faker::Lorem.characters(number: 1001)
      expect(user).to_not be_valid
    end
  end
end
