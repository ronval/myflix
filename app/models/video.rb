class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(movie_title)
     where("title LIKE ?", "%#{movie_title}%").order("created_at DESC")

  end




end 