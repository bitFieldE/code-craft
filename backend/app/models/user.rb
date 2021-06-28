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
  has_many :events, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

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

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # すでに登録されている古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # タグの生成
    new_tags.each do |new_name|
      user_tag = Tag.find_or_create_by(name: new_name)
      self.tags << user_tag
    end
  end

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
