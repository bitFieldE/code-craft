class User < ApplicationRecord
  include UserAuth::Tokenizable
  before_validation :downcase_email
  has_secure_password
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/.freeze
  attr_accessor :current_password

  has_one_attached :image

  # 他テーブルとのアソシエーション
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :user_tag_maps, dependent: :destroy
  has_many :tags, through: :user_tag_maps
  has_many :comments, dependent: :destroy
  has_many :event_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :join_events, dependent: :destroy
  has_many :event_joiner, through: :join_events, source: :event

  # カラムのバリデーション
  validates :name, presence: true, uniqueness: true,
                   length: { maximum: 15, allow_blank: true }
  validates :description, length: { maximum: 1000, allow_blank: true }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: {
                         with: VALID_PASSWORD_REGEX
                       },
                       allow_nil: true

  # ユーザーへのフォロー
  def follow(other_user)
    self.relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  # フォローを解除
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def image_url
    image.attached? ? url_for(image) : nil
  end

  private

  # email小文字化
  def downcase_email
    self.email.downcase! if email
  end
end
