class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  # カラムのバリデーション
  validates :content, presence: true
end
