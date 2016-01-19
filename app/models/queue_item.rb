class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_numericality_of :position, {only_integer: true}
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

  def method_name
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
  end




end 