require 'rails_helper'

RSpec.describe EventComment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:event) { create(:event, user: user, post: post) }
  let(:event_comment) { create(:event_comment, user: user, event: event) }

  context '掲示板のコメント作成時' do
    it 'contentが入力済みで成功' do
      expect(event_comment).to be_valid
    end

    it 'contentが未入力で失敗' do
      event_comment.content = ''
      expect(event_comment).to_not be_valid
    end
  end
end
