class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def created_date
    self.created_at&.strftime('%Y/%m/%d %H:%M')
  end
end
