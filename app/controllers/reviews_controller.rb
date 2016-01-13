class ReviewsController < ApplicationController
before_action :require_user  
  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params)
    
    review[:user_id] = current_user.id
    review.save
    
    if review.save
      redirect_to @video 

    else 
      @reviews = @video.reviews.reload
      render "videos/show"
      
    end 
  end




  private

  def review_params

    params.require(:review).permit(:review_content, :score,)
    
  end
end 