class Micropost < ActiveRecord::Base
  
  belongs_to :user
  
  default_scope -> { order('created_at DESC') }
  
  # ページあたりの表示件数。
  self.per_page = 10
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

end
