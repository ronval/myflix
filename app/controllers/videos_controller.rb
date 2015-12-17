class VideosController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @videos = Video.find(params[:id])
  end

  def search 
   
    @videos = Video.search_by_title(params[:search_term])

  end

end 
