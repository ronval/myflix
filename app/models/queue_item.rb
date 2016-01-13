class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  def video_title
    video.title
  end

  def score
    review = Review.where(user_id:user.id, video_id:video.id).first
    review.score if review 
  end

  def category_name
    video.category.category
    
  end
  def category
    video.category
  end
end 