class QueueItemsController < ApplicationController
  before_action :require_user
  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user:current_user, position:queue_item_position_number) unless current_user.queue_items.map(&:video).include?(video)
    redirect_to my_queue_path
  end


  private 

  def queue_item_position_number
    position_number = current_user.queue_items.count +1
    return position_number
  end

end 