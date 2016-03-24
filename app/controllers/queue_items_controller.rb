class QueueItemsController < ApplicationController
  before_action :require_user
  
  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    queue_video(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    normalize_queue_position
    redirect_to my_queue_path
  end

  def update_queue
    begin
      update_queue_items
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Please add a whole number no decimals"
      redirect_to my_queue_path
      return #we use return so the rest of the code doesnt run so we dont have a double redirect error
    end 
    normalize_queue_position
    redirect_to my_queue_path
  end

  private 

  def queue_video(video)
    QueueItem.create(video: video, user:current_user, position:queue_item_position_number) unless current_user_video_in_queued?(video)
  end


  def queue_item_position_number
   current_user.queue_items.count + 1
    
  end


  def current_user_video_in_queued?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def update_queue_items 
      ActiveRecord::Base.transaction do 
        params[:queue_items].each do |queue_item_data|
          queue_item = QueueItem.find(queue_item_data["id"])
          queue_item.update_attributes!(position:queue_item_data["position"], score:queue_item_data["rating"]) if queue_item.user == current_user
        end 
      end 
  end

  def normalize_queue_position
      current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end 
  end

end 