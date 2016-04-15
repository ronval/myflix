class Admin::VideosController <ApplicationController
  before_action :require_user
  before_action :require_admin
  
  def new
    @video =Video.new
  end

  def create
    @video = Video.new(video_params)
    
    if @video.valid?
      @video.save
      redirect_to new_admin_video_path
      flash[:notice] = "You have created a new video"
    else
      render :new
        flash[:notice] ="You missed some information"
    end 
  end

  private 
    def require_admin
      if !current_user.admin?
      redirect_to home_path 
      flash[:notice] = "You are not authorized to access that"
      end 
    end

    def video_params
      params.require(:video).permit(:title,:category_id,:description, :small_cover, :large_cover)
    end

end 