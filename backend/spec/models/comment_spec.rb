require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment) }

  context 'コメント作成時' do
    it 'contentが入力済みで成功' do
      expect(comment).to be_valid
    end

    it 'contentが未入力で失敗' do
      comment.content = ''
      expect(comment).to_not be_valid
    end
  end
end
