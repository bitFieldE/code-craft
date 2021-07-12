class Event < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :image
  has_many :event_tag_maps, dependent: :destroy
  has_many :tags, through: :event_tag_maps
  has_many :join_events, dependent: :destroy
  has_many :join_users, through: :join_events, source: :user
  has_many :event_comments, dependent: :destroy

  def image_url
    image.attached? ? url_for(image) : nil
  end

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
