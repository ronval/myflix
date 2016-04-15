class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> {order "created_at DESC"}
  validates :title, presence: true
  validates :description, presence: true

  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader


  def self.search_by_title(movie_title)
     if movie_title.blank?
      return []
    else 
     where("title LIKE ?", "%#{movie_title}%").order("created_at DESC")
   end 
  end




end 