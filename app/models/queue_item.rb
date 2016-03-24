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

  def score=(new_score)
    review = Review.where(user_id:user.id, video_id:video.id).first
    if review
      review.update_columns(score:new_score)
    else 
      review = Review.new(user:user, video:video, score:new_score)
      review.save(validate: false)
    end 
    
  end

  def category_name
    video.category.category
    
  end
  def category
    video.category
  end

  # def method_name
  #   current_user.queue_items.each_with_index do |queue_item, index|
  #     queue_item.update_attributes(position: index + 1)
  #   end 
  # end


  private

  def review
    @review ||= Review.where(user_id:user.id, video_id:video.id).first
  end




end 