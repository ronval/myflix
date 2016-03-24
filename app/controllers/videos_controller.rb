class VideosController < ApplicationController
  before_action :require_user, only:[:index, :show, :search]
  
  def home
    if logged_in?
      redirect_to home_path 
    end 
  end


  def index
    @categories = Category.all
  end

  def show
    @videos = Video.find(params[:id])
    @reviews = @videos.reviews
  end

  def search 
   
    @videos = Video.search_by_title(params[:search_term])

  end

end 
