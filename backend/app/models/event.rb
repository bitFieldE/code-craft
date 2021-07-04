class Event < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image
  has_many :join_events, dependent: :destroy
  has_many :join_users, through: :join_events, source: :user
  has_many :event_comments, dependent: :destroy

  def image_url
    image.attached? ? url_for(image) : nil
  end
end
