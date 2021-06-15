class Tag < ApplicationRecord
  has_many :post_tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tag_maps
end
