class VideosController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @videos = Video.find(params[:id])
  end

end 
