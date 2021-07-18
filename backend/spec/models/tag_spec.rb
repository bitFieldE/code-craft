require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { create(:tag) }

  context 'タグ作成時' do
    it 'nameが入力済みで成功' do
      expect(tag).to be_valid
    end

    it 'nameが未入力で失敗' do
      tag.name = ''
      expect(tag).to_not be_valid
    end

    it 'nameが25文字以内で成功' do
      tag.name = Faker::Lorem.characters(number: 15)
      expect(tag).to be_valid
    end

    it 'nameが25文字より多い場合失敗' do
      tag.name = Faker::Lorem.characters(number: 26)
      expect(tag).to_not be_valid
    end
  end
end
