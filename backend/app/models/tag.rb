class Tag < ApplicationRecord
  has_many :user_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :users, through: :user_tag_maps
  has_many :post_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tag_maps
  has_many :event_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :events, through: :event_tag_maps

  # カラムのバリデーション
  validates :name, presence: true, uniqueness: true,
                   length: { maximum: 25, allow_blank: true }
end
