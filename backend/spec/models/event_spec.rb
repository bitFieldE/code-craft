require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  context 'イベント作成時' do
    it 'title/participant_number/content/place/scheduled_date/start_time/end_timeが入力済みで成功' do
      expect(event).to be_valid
    end

    it 'title/participant_number/content/place/scheduled_date/start_time/end_timeが未入力で失敗' do
      event.title = ''
      event.participant_number = ''
      event.place = ''
      event.scheduled_date = ''
      event.start_time = ''
      event.end_time = ''
      expect(event).to_not be_valid
    end
  end

  context 'イベント更新時' do
    it 'participant_numberの値が50以下で成功' do
      event.participant_number = 40
      expect(event).to be_valid
    end

    it 'participant_numberの値が50より上で失敗' do
      event.participant_number = 51
      expect(event).to_not be_valid
    end
  end
end
