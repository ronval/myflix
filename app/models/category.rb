class Category <ActiveRecord::Base
  has_many :videos, -> {order "created_at DESC"}
  validates :category, presence: true 
  def recent_videos
    #category = Category.joins(:videos).order("created_at DESC").limit(6)
    videos.first(6)
  end









end 


