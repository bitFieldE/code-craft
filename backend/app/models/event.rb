class Event < ApplicationRecord
  belongs_to :user
  belongs_to :post
  mount_uploader :image, ImageUploader
  has_many :event_tag_maps, dependent: :destroy
  has_many :tags, through: :event_tag_maps
  has_many :join_events, dependent: :destroy
  has_many :join_users, through: :join_events, source: :user
  has_many :event_comments, dependent: :destroy

  # カラムのバリデーション
  validates :title, presence: true, length: { maximum: 50, allow_blank: true }
  validates :content, presence: true, length: { maximum: 1000, allow_blank: true }
  validates :participant_number, numericality: { greater_than: 0, less_than_or_equal_to: 50 }

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # すでに登録されているがフォームに含まれていない古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # タグの生成
    new_tags.each do |new_name|
      user_tag = Tag.find_or_create_by(name: new_name)
      self.tags << user_tag
    end
  end
end
